local olua = require "olua"
local autoconf = require "autoconf"
local M = autoconf.typemod 'cocos2d'
local typeconf = M.typeconf
local typeonly = M.typeonly
local include = M.include

M.PATH = '../../frameworks/libxgame/src/lua-bindings'
M.INCLUDES = [[
#include "lua-bindings/lua_cocos2d.h"
#include "lua-bindings/lua_conv.h"
#include "lua-bindings/lua_conv_manual.h"
#include "lua-bindings/LuaCocosAdapter.h"
#include "audio/include/AudioEngine.h"
#include "cocos2d.h"
#include "base/TGAlib.h"
#include "ui/CocosGUI.h"
#include "navmesh/CCNavMesh.h"
#include "xgame/xlua.h"
]]
M.CHUNK = [[
static const std::string makeScheduleCallbackTag(const std::string &key)
{
    return "schedule." + key;
}]]

include('conf/lua-cocos2d-types.lua')

M.MAKE_LUACLS = function (cppname)
    if cppname == 'ResolutionPolicy' then
        return 'cc.' .. cppname
    else
        cppname = string.gsub(cppname, "^cocos2d::network::", "cc.")
        cppname = string.gsub(cppname, "^cocos2d::", "cc.")
        cppname = string.gsub(cppname, "::", ".")
        return cppname
    end
end

M.EXCLUDE_TYPE = require "conf.exclude-type"

typeconf 'cocos2d::RenderTargetFlag'
typeconf 'cocos2d::ClearFlag'
typeconf 'cocos2d::MATRIX_STACK_TYPE'
typeconf 'cocos2d::Director::Projection'

typeconf 'cocos2d::UserDefault'
    .EXCLUDE 'setDelegate'

    
typeconf 'cocos2d::Ref'
    .EXCLUDE 'retain'
    .EXCLUDE 'release'
    .EXCLUDE 'autorelease'
    .FUNC('__gc', '{\n    return xlua_ccobjgc(L);\n}')
    
typeconf 'cocos2d::Console'
typeconf 'cocos2d::Acceleration'

local Director = typeconf 'cocos2d::Director'
Director.EXCLUDE 'getCocos2dThreadId'
Director.ATTR('getRunningScene', {RET = '@hold(coexist scenes)'})
Director.ATTR('runWithScene', {ARG1 = '@hold(coexist scenes)'})
Director.ATTR('pushScene', {ARG1 = '@hold(coexist scenes)'})
Director.ATTR('replaceScene', {RET = '@unhold(cmp scenes)', ARG1 = '@hold(coexist scenes)'})
Director.ATTR('popScene', {RET = '@unhold(cmp scenes)'})
Director.ATTR('popToRootScene', {RET = '@unhold(cmp scenes)'})
Director.ATTR('popToSceneStackLevel', {RET = '@unhold(cmp scenes)'})
Director.ATTR('getOpenGLView', {RET = '@hold(exclusive openGLView)'})
Director.ATTR('setOpenGLView', {ARG1 = '@hold(exclusive openGLView)'})
Director.ATTR('getTextureCache', {RET = '@hold(exclusive textureCache)'})
Director.ATTR('getNotificationNode', {RET = '@hold(exclusive notificationNode)'})
Director.ATTR('setNotificationNode', {ARG1 = '@hold(exclusive notificationNode)'})
Director.ATTR('convertToGL', {ARG1 = '@pack'})
Director.ATTR('convertToUI', {ARG1 = '@pack'})
Director.ATTR('getEventDispatcher', {RET = '@hold(exclusive eventDispatcher)'})
Director.ATTR('setEventDispatcher', {ARG1 = '@hold(exclusive eventDispatcher)'})
Director.ATTR('getScheduler', {RET = '@hold(exclusive scheduler)'})
Director.ATTR('setScheduler', {ARG1 = '@hold(exclusive scheduler)'})
Director.ATTR('getActionManager', {RET = '@hold(exclusive actionManager)'})
Director.ATTR('setActionManager', {ARG1 = '@hold(exclusive actionManager)'})
Director.ATTR('getRenderer', {RET = '@hold(exclusive renderer)'})

local Scheduler = typeconf 'cocos2d::Scheduler'
Scheduler.EXCLUDE 'performFunctionInCocosThread'
Scheduler.CHUNK = [[
template <typename T> bool doScheduleUpdate(lua_State *L)
{
    const char *cls = olua_getluatype<T>(L);
    if (olua_is_cppobj(L, 2, cls)) {
        auto self = olua_checkobj<cocos2d::Scheduler>(L, 1);
        auto target = olua_checkobj<T>(L, 2);
        lua_Integer priority = olua_checkinteger(L, 3);
        bool paused = olua_checkboolean(L, 4);
        self->scheduleUpdate(target, (int)priority, paused);
        return true;
    }

    return false;
}]]
Scheduler.CALLBACK {
    NAME = 'schedule',
    TAG_MAKER = 'makeScheduleCallbackTag(#-1)',
    TAG_MODE = 'OLUA_TAG_REPLACE',
    TAG_STORE = 2, -- 2th void *target
}
Scheduler.CALLBACK {
    NAME = 'unschedule',
    TAG_MAKER = 'makeScheduleCallbackTag(#1)',
    TAG_STORE = 2, -- 2th void *target
    TAG_MODE = 'OLUA_TAG_SUBEQUAL',
    REMOVE = true,
}
Scheduler.CALLBACK {
    NAME = 'unscheduleAllForTarget',
    TAG_MAKER = 'makeScheduleCallbackTag("")',
    TAG_MODE = 'OLUA_TAG_SUBSTARTWITH',
    TAG_STORE = 1, -- 1th void *target
    REMOVE = true,
}
Scheduler.CALLBACK {
    NAME = 'unscheduleAll',
    TAG_MAKER = 'makeScheduleCallbackTag("")',
    TAG_MODE = 'OLUA_TAG_SUBSTARTWITH',
    REMOVE = true,
}
Scheduler.FUNC('scheduleUpdate', [[
{
    if (doScheduleUpdate<cocos2d::Scheduler>(L) ||
        doScheduleUpdate<cocos2d::ActionManager>(L) ||
        doScheduleUpdate<cocos2d::Node>(L) ||
        doScheduleUpdate<cocos2d::Action>(L) ||
        doScheduleUpdate<cocos2d::Component>(L) ||
        doScheduleUpdate<cocos2d::ActionManager>(L)) {
        return 0;
    }

    luaL_error(L, "unsupport type: %s", olua_typename(L, 2));

    return 0;
}]])

--
-- event & event listener
--
local EventDispatcher = typeconf 'cocos2d::EventDispatcher'
EventDispatcher.ATTR('addEventListenerWithSceneGraphPriority', {ARG1 = '@hold(coexist listeners 3)'})
EventDispatcher.ATTR('addEventListenerWithFixedPriority', {ARG1 = '@hold(coexist listeners)'})
EventDispatcher.ATTR('removeCustomEventListeners', {RET = '@unhold(cmp listeners)'})
EventDispatcher.ATTR('removeEventListener', {RET = '@unhold(cmp listeners)'})
EventDispatcher.ATTR('removeEventListenersForType', {RET = '@unhold(cmp listeners)'})
EventDispatcher.ATTR('removeAllEventListeners', {RET = '@unhold(cmp listeners)'})
EventDispatcher.CHUNK = [[
static void doRemoveEventListenersForTarget(lua_State *L, cocos2d::Node *target, bool recursive, const char *refname)
{
    if (olua_getuserdata(L, target)) {
        olua_unholdall(L, -1, refname);
        lua_pop(L, 1);
    }
    if (recursive) {
        const auto &children = target->getChildren();
        for (const auto& child : children)
        {
            doRemoveEventListenersForTarget(L, child, recursive, refname);
        }
    }
}]]
EventDispatcher.FUNC('addCustomEventListener', [[
{
    void *callback_store_obj = nullptr;
    auto self = olua_checkobj<cocos2d::EventDispatcher>(L, 1);
    std::string eventName = olua_checkstring(L, 2);
    auto listener = new cocos2d::EventListenerCustom();
    listener->autorelease();
    olua_push_cppobj<cocos2d::EventListenerCustom>(L, listener);
    callback_store_obj = listener;
    std::string func = olua_setcallback(L, callback_store_obj, eventName.c_str(), 3, OLUA_TAG_NEW);
    listener->init(eventName, [callback_store_obj, func](cocos2d::EventCustom *event) {
        lua_State *L = olua_mainthread();
        int top = lua_gettop(L);
        size_t last = olua_push_objpool(L);
        olua_enable_objpool(L);
        olua_push_cppobj<cocos2d::EventCustom>(L, event);
        olua_disable_objpool(L);
        olua_callback(L, callback_store_obj, func.c_str(), 1);

        //pop stack value
        olua_pop_objpool(L, last);

        lua_settop(L, top);
    });

    // EventListenerCustom* EventDispatcher::addCustomEventListener(const std::string &eventName, const std::function<void(EventCustom*)>& callback)
    //  {
    //      EventListenerCustom *listener = EventListenerCustom::create(eventName, callback);
    //      addEventListenerWithFixedPriority(listener, 1);
    //      return listener;
    //  }
    self->addEventListenerWithFixedPriority(listener, 1);
    lua_pushvalue(L, 4);

    olua_hold(L, 1, "listeners", -1, OLUA_FLAG_COEXIST);

    return 1;
}]])
EventDispatcher.INJECT('removeEventListenersForTarget', {
    BEFORE = [[
        bool recursive = false;
        auto node = olua_checkobj<cocos2d::Node>(L, 2);
        if (lua_gettop(L) >= 3) {
            recursive = olua_toboolean(L, 3);
        }
        doRemoveEventListenersForTarget(L, node, recursive, "listeners");
    ]]
})

typeconf 'cocos2d::EventListener::Type'

typeconf 'cocos2d::EventListener'
    .EXCLUDE 'init'
    .PROP('available', 'bool checkAvailable()')

typeconf 'cocos2d::EventListenerTouchOneByOne'
typeconf 'cocos2d::EventListenerTouchAllAtOnce'

typeconf 'cocos2d::EventListenerCustom'
    .CALLBACK {
        NAME = 'create',
        TAG_MAKER = 'listener',
        TAG_MODE = 'OLUA_TAG_NEW',
        CPPFUNC = 'init',
    }

typeconf 'cocos2d::EventListenerKeyboard'

typeconf 'cocos2d::EventListenerAcceleration'
    .CALLBACK {
        NAME = 'create',
        TAG_MAKER = 'listener',
        TAG_MODE = 'OLUA_TAG_NEW',
        CPPFUNC = 'init',
    }

typeconf 'cocos2d::EventListenerFocus'
typeconf 'cocos2d::EventListenerMouse'
typeconf 'cocos2d::Event::Type'
typeconf 'cocos2d::Event'
typeconf 'cocos2d::EventCustom'
typeconf 'cocos2d::EventListenerController'
typeconf 'cocos2d::EventTouch::EventCode'
typeconf 'cocos2d::EventTouch'
typeconf 'cocos2d::EventKeyboard'
typeconf 'cocos2d::EventAcceleration'
typeconf 'cocos2d::EventFocus'
typeconf 'cocos2d::EventMouse::MouseEventType'
typeconf 'cocos2d::EventMouse::MouseButton'
typeconf 'cocos2d::EventMouse'
typeconf 'cocos2d::EventKeyboard::KeyCode'
typeconf 'cocos2d::Touch::DispatchMode'
typeconf 'cocos2d::EventController::ControllerEventType'
typeconf 'cocos2d::EventController'

typeconf 'cocos2d::Touch'
typeconf 'cocos2d::Controller::Key'

typeconf 'cocos2d::Controller'
    .EXCLUDE 'receiveExternalKeyEvent'

typeconf 'cocos2d::AudioProfile'
typeconf 'cocos2d::AudioEngine::AudioState'

local AudioEngine = typeconf 'cocos2d::AudioEngine'
AudioEngine.CHUNK = [[
NS_CC_BEGIN
class LuaAudioEngine : public cocos2d::AudioEngine
{
public:
    static std::list<int> getAudioIDs(const std::string &path)
    {
        std::list<int> list;
        auto it = _audioPathIDMap.find(path);
        if (it != _audioPathIDMap.end()) {
            list = it->second;
        }
        return list;
    }
};
NS_CC_END

static const std::string makeAudioEngineFinishCallbackTag(lua_Integer id)
{
    if (id < 0) {
        return "finishCallback.";
    } else {
        char buf[64];
        sprintf(buf, "finishCallback.%d", (int)id);
        return std::string(buf);
    }
}]]
AudioEngine.INJECT('uncache', {
    BEFORE = [[
        std::string path = olua_checkstring(L, 1);
        std::list<int> ids = cocos2d::LuaAudioEngine::getAudioIDs(path);
        const char *cls = olua_getluatype<cocos2d::AudioEngine>(L);
        void *callback_store_obj = (void *)olua_pushclassobj(L, cls);
        for (auto id : ids) {
            std::string tag = makeAudioEngineFinishCallbackTag((lua_Integer)id);
            olua_removecallback(L, callback_store_obj, tag.c_str(), OLUA_TAG_SUBEQUAL);
        }
    ]]
})
AudioEngine.CALLBACK {
    NAME = 'stop',
    TAG_MAKER = 'makeAudioEngineFinishCallbackTag(#1)',
    TAG_MODE = 'OLUA_TAG_SUBEQUAL',
    REMOVE = true,
}
AudioEngine.CALLBACK {
    NAME = 'stopAll',
    TAG_MAKER = 'makeAudioEngineFinishCallbackTag(-1)',
    TAG_MODE = "OLUA_TAG_SUBSTARTWITH",
    REMOVE = true,
}
AudioEngine.CALLBACK {
    NAME = 'uncacheAll',
    TAG_MAKER = 'makeAudioEngineFinishCallbackTag(-1)',
    TAG_MODE = "OLUA_TAG_SUBSTARTWITH",
    REMOVE = true,
}
AudioEngine.CALLBACK {
    NAME = 'setFinishCallback',
    TAG_MAKER = 'makeAudioEngineFinishCallbackTag(#1)',
    NULLABLE = true,
    CALLONCE = true,
}
AudioEngine.CALLBACK {
    NAME = 'preload',
    CALLONCE = true,
}

typeconf 'cocos2d::ApplicationProtocol::Platform'
typeconf 'cocos2d::LanguageType'
typeconf 'cocos2d::ApplicationProtocol'

typeconf 'cocos2d::Application'
    .EXCLUDE 'setStartupScriptFilename'
    .EXCLUDE 'applicationScreenSizeChanged'

typeconf 'cocos2d::Device'
    .EXCLUDE 'getTextureDataForText'

typeconf 'cocos2d::ResizableBuffer'
typeconf 'cocos2d::FileUtils::Status'

typeconf 'cocos2d::FileUtils'
    .ATTR('getFileDataFromZip', {RET = '@length(arg3)', ARG3 = '@out'})
    .ATTR('listFilesRecursively', {ARG2 = '@out'})
    .CALLBACK {NAME = "getStringFromFile", CALLONCE = true, TAG_MODE = 'OLUA_TAG_NEW'}
    .CALLBACK {NAME = "getDataFromFile", CALLONCE = true, TAG_MODE = 'OLUA_TAG_NEW'}
    .CALLBACK {NAME = "writeStringToFile", CALLONCE = true, TAG_MODE = 'OLUA_TAG_NEW'}
    .CALLBACK {NAME = "writeDataToFile", CALLONCE = true, TAG_MODE = 'OLUA_TAG_NEW'}
    .CALLBACK {NAME = "writeValueMapToFile", CALLONCE = true, TAG_MODE = 'OLUA_TAG_NEW'}
    .CALLBACK {NAME = "writeValueVectorToFile", CALLONCE = true, TAG_MODE = 'OLUA_TAG_NEW'}
    .CALLBACK {NAME = "isFileExist", CALLONCE = true, TAG_MODE = 'OLUA_TAG_NEW'}
    .CALLBACK {NAME = "isDirectoryExist", CALLONCE = true, TAG_MODE = 'OLUA_TAG_NEW'}
    .CALLBACK {NAME = "createDirectory", CALLONCE = true, TAG_MODE = 'OLUA_TAG_NEW'}
    .CALLBACK {NAME = "removeDirectory", CALLONCE = true, TAG_MODE = 'OLUA_TAG_NEW'}
    .CALLBACK {NAME = "removeFile", CALLONCE = true, TAG_MODE = 'OLUA_TAG_NEW'}
    .CALLBACK {NAME = "renameFile", CALLONCE = true, TAG_MODE = 'OLUA_TAG_NEW'}
    .CALLBACK {NAME = "getFileSize", CALLONCE = true, TAG_MODE = 'OLUA_TAG_NEW'}
    .CALLBACK {NAME = "listFilesAsync", CALLONCE = true, TAG_MODE = 'OLUA_TAG_NEW'}
    .CALLBACK {NAME = "listFilesRecursivelyAsync", CALLONCE = true, TAG_MODE = 'OLUA_TAG_NEW'}

typeconf 'ResolutionPolicy'
typeconf 'cocos2d::GLView'

typeconf 'cocos2d::GLViewImpl'
    .EXCLUDE 'create'
    .EXCLUDE 'createWithRect'
    .EXCLUDE 'createWithFullScreen'

typeconf 'cocos2d::Image::Format'

local Image = typeconf 'cocos2d::Image'
Image.CHUNK = [[
NS_CC_BEGIN
class LuaImage : public cocos2d::Image {
public:
    static bool getPNGPremultipliedAlphaEnabled() { return PNG_PREMULTIPLIED_ALPHA_ENABLED; };
};
NS_CC_END
]]
Image.FUNC('getPNGPremultipliedAlphaEnabled', [[
{
    lua_pushboolean(L, cocos2d::LuaImage::getPNGPremultipliedAlphaEnabled());
    return 1;
}]])

typeconf 'cocos2d::Properties::Type'
typeconf 'cocos2d::Properties'
    .ATTR('getPath', {ARG2 = '@out'})

typeconf 'cocos2d::Material'
typeconf 'cocos2d::Renderer'
typeconf 'cocos2d::RenderCommand::Type'
typeconf 'cocos2d::CustomCommand::DrawType'
typeonly 'cocos2d::Technique'
typeonly 'cocos2d::Pass'
typeonly 'cocos2d::RenderState'
typeonly 'cocos2d::RenderCommand'
typeonly 'cocos2d::CustomCommand'
typeonly 'cocos2d::MeshCommand'

local TextureCache = typeconf 'cocos2d::TextureCache'
TextureCache.CHUNK = [[
static const std::string makeTextureCacheCallbackTag(const std::string &key)
{
    return "addImageAsync." + key;
}]]
TextureCache.CALLBACK {
    NAME = 'addImageAsync',
    TAG_MAKER = {'makeTextureCacheCallbackTag(#1)', 'makeTextureCacheCallbackTag(#-1)'},
    TAG_MODE = 'OLUA_TAG_REPLACE',
    CALLONCE = true,
    LOCAL = false,
}
TextureCache.CALLBACK {
    NAME = 'unbindImageAsync',
    TAG_MAKER = 'makeTextureCacheCallbackTag(#1)',
    TAG_MODE = 'OLUA_TAG_SUBEQUAL',
    REMOVE = true,
}
TextureCache.CALLBACK {
    NAME = 'unbindAllImageAsync',
    TAG_MAKER = 'makeTextureCacheCallbackTag("")',
    TAG_MODE = 'OLUA_TAG_SUBSTARTWITH',
    REMOVE = true,
}

typeconf 'cocos2d::Texture2D'
typeconf 'cocos2d::TextureCube'
typeconf 'cocos2d::TextureAtlas'

typeconf 'cocos2d::network::WebSocket::ErrorCode'
typeconf 'cocos2d::network::WebSocket::State'
typeconf 'cocos2d::network::WebSocket::Delegate'

local WebSocket = typeconf 'cocos2d::network::WebSocket'
WebSocket.FUNC('init', [[
{
    std::vector<std::string> protocols;
    auto self =  olua_toobj<cocos2d::network::WebSocket>(L, 1);
    auto delegate = olua_checkobj<cocos2d::network::WebSocket::Delegate>(L, 2);
    std::string url = olua_tostring(L, 3);
    std::string cafile = olua_optstring(L, 5, "");

    if (!lua_isnil(L, 4)) {
        luaL_checktype(L, 4, LUA_TTABLE);
        int len = (int)lua_rawlen(L, 4);
        protocols.reserve(len);
        for (int i = 1; i <= len; i++) {
            lua_rawgeti(L, 4, i);
            protocols.push_back(olua_checkstring(L, -1));
            lua_pop(L, 1);
        }
    }

    self->init(*delegate, url, protocols.size() > 0 ? &protocols : nullptr, cafile);
    olua_hold(L, 1, "delegate", 2, OLUA_FLAG_EXCLUSIVE);

    return 0;
}]])

local LuaWebSocketDelegate = typeconf 'cocos2d::LuaWebSocketDelegate'
LuaWebSocketDelegate.MAKE_LUANAME = function (name)
    return string.gsub(name, 'Callback', '')
end

typeconf 'cocos2d::ActionManager'
typeconf 'cocos2d::Component'

local LuaComponent = typeconf 'cocos2d::LuaComponent'
LuaComponent.MAKE_LUANAME = function (name)
    return string.gsub(name, 'Callback', '')
end

-- node
local Node = typeconf 'cocos2d::Node'
Node.EXCLUDE 'scheduleUpdateWithPriorityLua'
Node.EXCLUDE 'enumerateChildren' -- TODO
Node.ATTR('addChild', {ARG1 = '@hold(coexist children)'})
Node.ATTR('getChildByTag', {RET = '@hold(coexist children)'})
Node.ATTR('getChildByName', {RET = '@hold(coexist children)'})
Node.ATTR('getChildren', {RET = '@hold(coexist children)'})
Node.ATTR('removeFromParent', {RET = '@unhold(coexist children parent)'})
Node.ATTR('removeFromParentAndCleanup', {RET = '@unhold(coexist children parent)'})
Node.ATTR('removeChild', {ARG1 = '@unhold(coexist children)'})
Node.ATTR('removeChildByTag', {RET = '@unhold(cmp children)'})
Node.ATTR('removeChildByName', {RET = '@unhold(cmp children)'})
Node.ATTR('removeAllChildren', {RET = '@unhold(all children)'})
Node.ATTR('removeAllChildrenWithCleanup', {RET = '@unhold(all children)'})
Node.ATTR('getGLProgram', {RET = '@hold(exclusive glProgram)'})
Node.ATTR('setGLProgram', {ARG1 = '@hold(exclusive glProgram)'})
Node.ATTR('getGLProgramState', {RET = '@hold(exclusive glProgramState)'})
Node.ATTR('setGLProgramState', {ARG1 = '@hold(exclusive glProgramState)'})
Node.ATTR('getEventDispatcher', {RET = '@hold(exclusive eventDispatcher)'})
Node.ATTR('setEventDispatcher', {ARG1 = '@hold(exclusive eventDispatcher)'})
Node.ATTR('getActionManager', {RET = '@hold(exclusive actionManager)'})
Node.ATTR('setActionManager', {ARG1 = '@hold(exclusive actionManager)'})
Node.ATTR('runAction', {RET = '@unhold(cmp actions)', ARG1 = '@hold(coexist actions)'})
Node.ATTR('stopAllActions', {RET = '@unhold(cmp actions)'})
Node.ATTR('stopAction', {RET = '@unhold(cmp actions)'})
Node.ATTR('stopActionByTag', {RET = '@unhold(cmp actions)'})
Node.ATTR('stopAllActionsByTag', {RET = '@unhold(cmp actions)'})
Node.ATTR('stopActionsByFlags', {RET = '@unhold(cmp actions)'})
Node.ATTR('getActionByTag', {RET = '@hold(coexist actions)'})
Node.ATTR('setScheduler', {ARG1 = '@hold(exclusive scheduler)'})
Node.ATTR('getScheduler', {RET = '@hold(exclusive scheduler)'})
Node.ATTR('convertToNodeSpace', {ARG1 = '@pack'})
Node.ATTR('convertToWorldSpace', {ARG1 = '@pack'})
Node.ATTR('convertToNodeSpaceAR', {ARG1 = '@pack'})
Node.ATTR('convertToWorldSpaceAR', {ARG1 = '@pack'})
Node.ATTR('getComponent', {RET = '@hold(coexist components)'})
Node.ATTR('addComponent', {ARG1 = '@hold(coexist components)'})
Node.ATTR('removeComponent', {RET = '@unhold(cmp components)'})
Node.ATTR('removeAllComponents', {RET = '@unhold(all components)'})
Node.ATTR('setPhysicsBody', {ARG1 = '@hold(exclusive physicsBody)'})
Node.ATTR('getPhysicsBody', {RET = '@hold(exclusive physicsBody)'})
Node.CHUNK = [[
static cocos2d::Node *_find_ancestor(cocos2d::Node *node1, cocos2d::Node *node2)
{
    for (auto *p1 = node1; p1 != nullptr; p1 = p1->getParent()) {
        for (auto *p2 = node2; p2 != nullptr; p2 = p2->getParent()) {
            if (p1 == p2) {
                return p1;
            }
        }
    }
    return NULL;
}]]
Node.FUNC('getBounds', [[
{
    auto self = olua_checkobj<cocos2d::Node>(L, 1);
    auto target = olua_checkobj<cocos2d::Node>(L, 2);

    float left = luaL_checknumber(L, 3);
    float right = luaL_checknumber(L, 4);
    float top = luaL_checknumber(L, 5);
    float bottom = luaL_checknumber(L, 6);

    cocos2d::Vec3 p1(left, bottom, 0);
    cocos2d::Vec3 p2(right, top, 0);

    auto m = cocos2d::Mat4::IDENTITY;

    if (target == self->getParent()) {
        m = self->getNodeToParentTransform();
    } else if (target != self) {
        auto ancestor = _find_ancestor(target, self);
        if (!ancestor) {
            m = target->getWorldToNodeTransform() * self->getNodeToWorldTransform();
        } else if (target == ancestor) {
            m = self->getNodeToParentTransform(target);
        } else if (self == ancestor) {
            m = target->getNodeToParentTransform(self).getInversed();
        } else {
            m = target->getNodeToParentTransform(ancestor).getInversed() * self->getNodeToParentTransform(ancestor);
        }
    }

    m.transformPoint(&p1);
    m.transformPoint(&p2);

    left = MIN(p1.x, p2.x);
    right = MAX(p1.x, p2.x);
    top = MAX(p1.y, p2.y);
    bottom = MIN(p1.y, p2.y);

    lua_pushnumber(L, left);
    lua_pushnumber(L, right);
    lua_pushnumber(L, top);
    lua_pushnumber(L, bottom);

    return 4;
}
]])
Node.PROP('x', 'float getPositionX()', 'void setPositionX(float x)')
Node.PROP('y', 'float getPositionY()', 'void setPositionY(float y)')
Node.PROP('z', 'float getPositionZ()', 'void setPositionZ(float z)')
Node.PROP('anchorX', [[
{
    auto self = olua_toobj<cocos2d::Node>(L, 1);
    lua_pushnumber(L, self->getAnchorPoint().x);
    return 1;
}
]], [[
{
    auto self = olua_toobj<cocos2d::Node>(L, 1);
    cocos2d::Vec2 anchor = self->getAnchorPoint();
    anchor.x = olua_checknumber(L, 2);
    self->setAnchorPoint(anchor);
    return 0;
}]])
Node.PROP('anchorY', [[
{
    auto self = olua_toobj<cocos2d::Node>(L, 1);
    lua_pushnumber(L, self->getAnchorPoint().y);
    return 1;
}
]], [[
{
    auto self = olua_toobj<cocos2d::Node>(L, 1);
    cocos2d::Vec2 anchor = self->getAnchorPoint();
    anchor.y = olua_checknumber(L, 2);
    self->setAnchorPoint(anchor);
    return 0;
}]])
Node.PROP('width', [[
{
    auto self = olua_toobj<cocos2d::Node>(L, 1);
    lua_pushnumber(L, self->getContentSize().width);
    return 1;
}
]], [[
{
    auto self = olua_toobj<cocos2d::Node>(L, 1);
    cocos2d::Size size = self->getContentSize();
    size.width = olua_checknumber(L, 2);
    self->setContentSize(size);
    return 0;
}]])
Node.PROP('height', [[
{
    auto self = olua_toobj<cocos2d::Node>(L, 1);
    lua_pushnumber(L, self->getContentSize().height);
    return 1;
}
]], [[
{
    auto self = olua_toobj<cocos2d::Node>(L, 1);
    cocos2d::Size size = self->getContentSize();
    size.height = olua_checknumber(L, 2);
    self->setContentSize(size);
    return 0;
}]])
Node.PROP('alpha', [[
{
    auto self = olua_toobj<cocos2d::Node>(L, 1);
    lua_pushnumber(L, self->getOpacity() / 255.0f);
    return 1;
}
]], [[
{
    auto self = olua_toobj<cocos2d::Node>(L, 1);
    self->setOpacity(olua_checknumber(L, 2) * 255.0f);
    return 0;
}]])
Node.CALLBACK {NAME = 'setOnEnterCallback', NULLABLE = true}
Node.CALLBACK {NAME = 'getOnEnterCallback', NULLABLE = true}
Node.CALLBACK {NAME = 'setOnExitCallback', NULLABLE = true}
Node.CALLBACK {NAME = 'getOnExitCallback', NULLABLE = true}
Node.CALLBACK {NAME = 'setOnEnterTransitionDidFinishCallback', NULLABLE = true}
Node.CALLBACK {NAME = 'getOnEnterTransitionDidFinishCallback', NULLABLE = true}
Node.CALLBACK {NAME = 'setOnExitTransitionDidStartCallback', NULLABLE = true}
Node.CALLBACK {NAME = 'getOnExitTransitionDidStartCallback', NULLABLE = true}
Node.CALLBACK {
    NAME = 'scheduleOnce',
    TAG_MAKER = 'makeScheduleCallbackTag(#-1)',
    TAG_MODE = 'OLUA_TAG_REPLACE',
    CALLONCE = true,
}
Node.CALLBACK {
    NAME = 'schedule',
    TAG_MAKER = "makeScheduleCallbackTag(#-1)",
    TAG_MODE = 'OLUA_TAG_REPLACE',
}
Node.CALLBACK {
    NAME = 'unschedule',
    TAG_MAKER = "makeScheduleCallbackTag(#1)",
    TAG_MODE = 'OLUA_TAG_SUBEQUAL',
    REMOVE = true,
}
Node.CALLBACK {
    NAME = 'unscheduleAllCallbacks',
    TAG_MAKER = 'makeScheduleCallbackTag("")',
    TAG_MODE = "OLUA_TAG_SUBSTARTWITH",
    REMOVE = true,
}
Node.INJECT({'removeFromParent', 'removeFromParentAndCleanup'}, {
    BEFORE = [[
        if (!self->getParent()) {
            return 0;
        }
        olua_push_cppobj<cocos2d::Node>(L, self->getParent());
        int parent = lua_gettop(L);
    ]]
})

typeconf 'cocos2d::AtlasNode'
typeconf 'cocos2d::sImageTGA'
typeconf 'cocos2d::TileMapAtlas'
typeconf 'cocos2d::ClippingNode'
typeconf 'cocos2d::MotionStreak'

typeconf 'cocos2d::ProtectedNode'
    .ATTR('addProtectedChild', {ARG1 = '@hold(coexist protectedChildren)'})
    .ATTR('getProtectedChildByTag', {RET = '@hold(coexist protectedChildren)'})
    .ATTR('removeProtectedChild', {ARG1 = '@unhold(coexist protectedChildren)'})
    .ATTR('removeProtectedChildByTag', {RET = '@unhold(cmp protectedChildren)'})
    .ATTR('removeAllProtectedChildren', {RET= '@unhold(all protectedChildren)'})
    .ATTR('removeAllProtectedChildrenWithCleanup', {RET = '@unhold(all protectedChildren)'})

typeconf 'cocos2d::DrawNode'
typeconf 'cocos2d::ParallaxNode'
typeconf 'cocos2d::TextHAlignment'
typeconf 'cocos2d::TextVAlignment'
typeconf 'cocos2d::GlyphCollection'
typeconf 'cocos2d::LabelEffect'
typeconf 'cocos2d::Label::LabelType'
typeconf 'cocos2d::Label::Overflow'
typeconf 'cocos2d::Label'
typeconf 'cocos2d::LabelAtlas'

typeconf 'cocos2d::FontAtlas'
    .EXCLUDE 'getTextures'
    .EXCLUDE 'prepareLetterDefinitions'

typeconf 'cocos2d::ClippingRectangleNode'

local RenderTexture = typeconf 'cocos2d::RenderTexture'
RenderTexture.CALLBACK {
    NAME = 'saveToFile',
    LOCAL = false,
    CALLONCE = true,
}
RenderTexture.CALLBACK {
    NAME = 'saveToFileAsNonPMA',
    TAG_MAKER = 'saveToFile',
    LOCAL = false,
    CALLONCE = true,
}
RenderTexture.CALLBACK {
    NAME = 'newImage',
    TAG_MODE = 'OLUA_TAG_NEW',
    LOCAL = false,
    CALLONCE = true,
}
RenderTexture.ALIAS('begin', 'beginVisit')
RenderTexture.ALIAS('end', 'endVisit')

typeconf 'cocos2d::ProgressTimer::Type'
typeconf 'cocos2d::ProgressTimer'
typeconf 'cocos2d::AnimationFrame'
typeconf 'cocos2d::Animation'
typeconf 'cocos2d::SpriteFrame'
typeconf 'cocos2d::Sprite'
typeconf 'cocos2d::SpriteBatchNode'
typeconf 'cocos2d::SpriteFrameCache'
typeconf 'cocos2d::AnimationCache'

local Scene = typeconf 'cocos2d::Scene'
Scene.ATTR('getPhysicsWorld', {RET = '@hold(exclusive physicsWorld)'})
Scene.ATTR('getPhysics3DWorld', {RET = '@hold(exclusive physics3DWorld)'})

typeconf 'cocos2d::Layer'
typeconf 'cocos2d::LayerColor'
typeconf 'cocos2d::LayerGradient'
typeconf 'cocos2d::LayerRadialGradient'
typeconf 'cocos2d::LayerMultiplex'

typeconf 'cocos2d::TransitionScene::Orientation'

local function typeconfTransition(name)
    local cls = typeconf(name)
    cls.ATTR('create', {ARG2 = '@hold(coexist autoref)'})
    cls.ATTR('easeActionWithAction', {ARG1 = '@hold(exclusive action)'})
    return cls
end

local TransitionScene = typeconfTransition 'cocos2d::TransitionScene'
TransitionScene.EXCLUDE 'initWithDuration'

typeconfTransition 'cocos2d::TransitionSceneOriented'
typeconfTransition 'cocos2d::TransitionRotoZoom'
typeconfTransition 'cocos2d::TransitionJumpZoom'
typeconfTransition 'cocos2d::TransitionMoveInL'
typeconfTransition 'cocos2d::TransitionMoveInR'
typeconfTransition 'cocos2d::TransitionMoveInT'
typeconfTransition 'cocos2d::TransitionMoveInB'
typeconfTransition 'cocos2d::TransitionSlideInL'
typeconfTransition 'cocos2d::TransitionSlideInR'
typeconfTransition 'cocos2d::TransitionSlideInB'
typeconfTransition 'cocos2d::TransitionSlideInT'
typeconfTransition 'cocos2d::TransitionShrinkGrow'
typeconfTransition 'cocos2d::TransitionFlipX'
typeconfTransition 'cocos2d::TransitionFlipY'
typeconfTransition 'cocos2d::TransitionFlipAngular'
typeconfTransition 'cocos2d::TransitionZoomFlipX'
typeconfTransition 'cocos2d::TransitionZoomFlipY'
typeconfTransition 'cocos2d::TransitionZoomFlipAngular'
typeconfTransition 'cocos2d::TransitionFade'
typeconfTransition 'cocos2d::TransitionCrossFade'
typeconfTransition 'cocos2d::TransitionTurnOffTiles'
typeconfTransition 'cocos2d::TransitionSplitCols'
typeconfTransition 'cocos2d::TransitionSplitRows'
typeconfTransition 'cocos2d::TransitionFadeTR'
typeconfTransition 'cocos2d::TransitionFadeBL'
typeconfTransition 'cocos2d::TransitionFadeUp'
typeconfTransition 'cocos2d::TransitionFadeDown'
typeconfTransition 'cocos2d::TransitionPageTurn'
typeconfTransition 'cocos2d::TransitionProgress'
typeconfTransition 'cocos2d::TransitionProgressRadialCCW'
typeconfTransition 'cocos2d::TransitionProgressRadialCW'
typeconfTransition 'cocos2d::TransitionProgressHorizontal'
typeconfTransition 'cocos2d::TransitionProgressVertical'
typeconfTransition 'cocos2d::TransitionProgressInOut'
typeconfTransition 'cocos2d::TransitionProgressOutIn'

typeconf 'cocos2d::TextFieldDelegate'
typeconf 'cocos2d::TextFieldTTF'

typeconf 'cocos2d::LightType'
typeconf 'cocos2d::LightFlag'
typeconf 'cocos2d::BaseLight'
typeconf 'cocos2d::DirectionLight'
typeconf 'cocos2d::PointLight'
typeconf 'cocos2d::SpotLight'
typeconf 'cocos2d::AmbientLight'
typeconf 'cocos2d::CameraFlag'
typeconf 'cocos2d::Camera::Type'

typeconf 'cocos2d::Camera'
    .EXCLUDE 'isVisibleInFrustum'
    .EXCLUDE 'setFrameBufferObject'

typeconf 'cocos2d::CameraBackgroundBrush::BrushType'
typeconf 'cocos2d::CameraBackgroundBrush'
typeconf 'cocos2d::CameraBackgroundDepthBrush'
typeconf 'cocos2d::CameraBackgroundColorBrush'
typeconf 'cocos2d::CameraBackgroundSkyBoxBrush'

typeconf 'cocos2d::ParticleBatchNode'
typeconf 'cocos2d::ParticleSystem::Mode'
typeconf 'cocos2d::ParticleSystem::PositionType'
typeconf 'cocos2d::ParticleSystem'
typeconf 'cocos2d::ParticleSystemQuad'
typeconf 'cocos2d::ParticleExplosion'
typeconf 'cocos2d::ParticleFire'
typeconf 'cocos2d::ParticleFireworks'
typeconf 'cocos2d::ParticleFlower'
typeconf 'cocos2d::ParticleGalaxy'
typeconf 'cocos2d::ParticleMeteor'
typeconf 'cocos2d::ParticleRain'
typeconf 'cocos2d::ParticleSmoke'
typeconf 'cocos2d::ParticleSnow'
typeconf 'cocos2d::ParticleSpiral'
typeconf 'cocos2d::ParticleSun'

typeconf 'cocos2d::TMXTileFlags'
typeconf 'cocos2d::TMXObjectGroup'

typeconf 'cocos2d::TMXLayer'
    .ATTR('getTileGIDAt', {ARG2 = '@out'})

typeconf 'cocos2d::TMXLayerInfo'
typeconf 'cocos2d::TMXMapInfo'
typeconf 'cocos2d::TMXTilesetInfo'
typeconf 'cocos2d::TMXTiledMap'
typeconf 'cocos2d::FastTMXTiledMap'

typeconf 'cocos2d::FastTMXLayer'
    .ATTR('getTileGIDAt', {ARG2 = '@out'})

typeconf 'cocos2d::NavMeshAgent::NavMeshAgentSyncFlag'
typeconf 'cocos2d::NavMeshAgent'
typeconf 'cocos2d::NavMeshObstacle::NavMeshObstacleSyncFlag'
typeconf 'cocos2d::NavMeshObstacle'
typeconf 'cocos2d::NavMesh'

return M