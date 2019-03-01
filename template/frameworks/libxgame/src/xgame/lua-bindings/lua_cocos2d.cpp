//
// generated by tolua
//
#include "xgame/lua-bindings/lua_cocos2d.h"
#include "xgame/xlua.h"
#include "xgame/xlua-conv.h"
#include "cocos2d.h"

static int _cocos2d_UserDefault_getBoolForKey1(lua_State *L)
{
    lua_settop(L, 2);
    cocos2d::UserDefault *self = (cocos2d::UserDefault *)xluacv_to_obj(L, 1, "cc.UserDefault");
    const char *arg1 = (const char *)xluacv_to_string(L, 2);
    bool ret = (bool)self->getBoolForKey(arg1);
    return xluacv_push_bool(L, ret);
}

static int _cocos2d_UserDefault_getBoolForKey2(lua_State *L)
{
    lua_settop(L, 3);
    cocos2d::UserDefault *self = (cocos2d::UserDefault *)xluacv_to_obj(L, 1, "cc.UserDefault");
    const char *arg1 = (const char *)xluacv_to_string(L, 2);
    bool arg2 = (bool)xluacv_to_bool(L, 3);
    bool ret = (bool)self->getBoolForKey(arg1, arg2);
    return xluacv_push_bool(L, ret);
}

static int _cocos2d_UserDefault_getBoolForKey(lua_State *L)
{
    int num_args = lua_gettop(L) - 1;

    if (num_args == 1) {
        // if (xluacv_is_string(L, 2)) {
            return _cocos2d_UserDefault_getBoolForKey1(L);
        // }
    }
    
    if (num_args == 2) {
        // if (xluacv_is_string(L, 2) && xluacv_is_bool(L, 3)) {
            return _cocos2d_UserDefault_getBoolForKey2(L);
        // }
    }

    luaL_error(L, "method 'cocos2d::UserDefault::getBoolForKey' not support '%d' arguments", num_args);

    return 0;
}

static int _cocos2d_UserDefault_getIntegerForKey1(lua_State *L)
{
    lua_settop(L, 2);
    cocos2d::UserDefault *self = (cocos2d::UserDefault *)xluacv_to_obj(L, 1, "cc.UserDefault");
    const char *arg1 = (const char *)xluacv_to_string(L, 2);
    int ret = (int)self->getIntegerForKey(arg1);
    return xluacv_push_int(L, ret);
}

static int _cocos2d_UserDefault_getIntegerForKey2(lua_State *L)
{
    lua_settop(L, 3);
    cocos2d::UserDefault *self = (cocos2d::UserDefault *)xluacv_to_obj(L, 1, "cc.UserDefault");
    const char *arg1 = (const char *)xluacv_to_string(L, 2);
    int arg2 = (int)xluacv_to_int(L, 3);
    int ret = (int)self->getIntegerForKey(arg1, arg2);
    return xluacv_push_int(L, ret);
}

static int _cocos2d_UserDefault_getIntegerForKey(lua_State *L)
{
    int num_args = lua_gettop(L) - 1;

    if (num_args == 1) {
        // if (xluacv_is_string(L, 2)) {
            return _cocos2d_UserDefault_getIntegerForKey1(L);
        // }
    }
    
    if (num_args == 2) {
        // if (xluacv_is_string(L, 2) && xluacv_is_int(L, 3)) {
            return _cocos2d_UserDefault_getIntegerForKey2(L);
        // }
    }

    luaL_error(L, "method 'cocos2d::UserDefault::getIntegerForKey' not support '%d' arguments", num_args);

    return 0;
}

static int _cocos2d_UserDefault_getFloatForKey1(lua_State *L)
{
    lua_settop(L, 2);
    cocos2d::UserDefault *self = (cocos2d::UserDefault *)xluacv_to_obj(L, 1, "cc.UserDefault");
    const char *arg1 = (const char *)xluacv_to_string(L, 2);
    float ret = (float)self->getFloatForKey(arg1);
    return xluacv_push_number(L, ret);
}

static int _cocos2d_UserDefault_getFloatForKey2(lua_State *L)
{
    lua_settop(L, 3);
    cocos2d::UserDefault *self = (cocos2d::UserDefault *)xluacv_to_obj(L, 1, "cc.UserDefault");
    const char *arg1 = (const char *)xluacv_to_string(L, 2);
    float arg2 = (float)xluacv_to_number(L, 3);
    float ret = (float)self->getFloatForKey(arg1, arg2);
    return xluacv_push_number(L, ret);
}

static int _cocos2d_UserDefault_getFloatForKey(lua_State *L)
{
    int num_args = lua_gettop(L) - 1;

    if (num_args == 1) {
        // if (xluacv_is_string(L, 2)) {
            return _cocos2d_UserDefault_getFloatForKey1(L);
        // }
    }
    
    if (num_args == 2) {
        // if (xluacv_is_string(L, 2) && xluacv_is_number(L, 3)) {
            return _cocos2d_UserDefault_getFloatForKey2(L);
        // }
    }

    luaL_error(L, "method 'cocos2d::UserDefault::getFloatForKey' not support '%d' arguments", num_args);

    return 0;
}

static int _cocos2d_UserDefault_getDoubleForKey1(lua_State *L)
{
    lua_settop(L, 2);
    cocos2d::UserDefault *self = (cocos2d::UserDefault *)xluacv_to_obj(L, 1, "cc.UserDefault");
    const char *arg1 = (const char *)xluacv_to_string(L, 2);
    double ret = (double)self->getDoubleForKey(arg1);
    return xluacv_push_number(L, ret);
}

static int _cocos2d_UserDefault_getDoubleForKey2(lua_State *L)
{
    lua_settop(L, 3);
    cocos2d::UserDefault *self = (cocos2d::UserDefault *)xluacv_to_obj(L, 1, "cc.UserDefault");
    const char *arg1 = (const char *)xluacv_to_string(L, 2);
    double arg2 = (double)xluacv_to_number(L, 3);
    double ret = (double)self->getDoubleForKey(arg1, arg2);
    return xluacv_push_number(L, ret);
}

static int _cocos2d_UserDefault_getDoubleForKey(lua_State *L)
{
    int num_args = lua_gettop(L) - 1;

    if (num_args == 1) {
        // if (xluacv_is_string(L, 2)) {
            return _cocos2d_UserDefault_getDoubleForKey1(L);
        // }
    }
    
    if (num_args == 2) {
        // if (xluacv_is_string(L, 2) && xluacv_is_number(L, 3)) {
            return _cocos2d_UserDefault_getDoubleForKey2(L);
        // }
    }

    luaL_error(L, "method 'cocos2d::UserDefault::getDoubleForKey' not support '%d' arguments", num_args);

    return 0;
}

static int _cocos2d_UserDefault_getStringForKey1(lua_State *L)
{
    lua_settop(L, 2);
    cocos2d::UserDefault *self = (cocos2d::UserDefault *)xluacv_to_obj(L, 1, "cc.UserDefault");
    const char *arg1 = (const char *)xluacv_to_string(L, 2);
    std::string ret = (std::string)self->getStringForKey(arg1);
    return xluacv_push_std_string(L, ret);
}

static int _cocos2d_UserDefault_getStringForKey2(lua_State *L)
{
    lua_settop(L, 3);
    cocos2d::UserDefault *self = (cocos2d::UserDefault *)xluacv_to_obj(L, 1, "cc.UserDefault");
    const char *arg1 = (const char *)xluacv_to_string(L, 2);
    const std::string arg2 = (const std::string)xluacv_to_std_string(L, 3);
    std::string ret = (std::string)self->getStringForKey(arg1, arg2);
    return xluacv_push_std_string(L, ret);
}

static int _cocos2d_UserDefault_getStringForKey(lua_State *L)
{
    int num_args = lua_gettop(L) - 1;

    if (num_args == 1) {
        // if (xluacv_is_string(L, 2)) {
            return _cocos2d_UserDefault_getStringForKey1(L);
        // }
    }
    
    if (num_args == 2) {
        // if (xluacv_is_string(L, 2) && xluacv_is_std_string(L, 3)) {
            return _cocos2d_UserDefault_getStringForKey2(L);
        // }
    }

    luaL_error(L, "method 'cocos2d::UserDefault::getStringForKey' not support '%d' arguments", num_args);

    return 0;
}

static int _cocos2d_UserDefault_setBoolForKey(lua_State *L)
{
    lua_settop(L, 3);
    cocos2d::UserDefault *self = (cocos2d::UserDefault *)xluacv_to_obj(L, 1, "cc.UserDefault");
    const char *arg1 = (const char *)xluacv_to_string(L, 2);
    bool arg2 = (bool)xluacv_to_bool(L, 3);
    self->setBoolForKey(arg1, arg2);
    return 0;
}

static int _cocos2d_UserDefault_setIntegerForKey(lua_State *L)
{
    lua_settop(L, 3);
    cocos2d::UserDefault *self = (cocos2d::UserDefault *)xluacv_to_obj(L, 1, "cc.UserDefault");
    const char *arg1 = (const char *)xluacv_to_string(L, 2);
    int arg2 = (int)xluacv_to_int(L, 3);
    self->setIntegerForKey(arg1, arg2);
    return 0;
}

static int _cocos2d_UserDefault_setFloatForKey(lua_State *L)
{
    lua_settop(L, 3);
    cocos2d::UserDefault *self = (cocos2d::UserDefault *)xluacv_to_obj(L, 1, "cc.UserDefault");
    const char *arg1 = (const char *)xluacv_to_string(L, 2);
    float arg2 = (float)xluacv_to_number(L, 3);
    self->setFloatForKey(arg1, arg2);
    return 0;
}

static int _cocos2d_UserDefault_setDoubleForKey(lua_State *L)
{
    lua_settop(L, 3);
    cocos2d::UserDefault *self = (cocos2d::UserDefault *)xluacv_to_obj(L, 1, "cc.UserDefault");
    const char *arg1 = (const char *)xluacv_to_string(L, 2);
    double arg2 = (double)xluacv_to_number(L, 3);
    self->setDoubleForKey(arg1, arg2);
    return 0;
}

static int _cocos2d_UserDefault_setStringForKey(lua_State *L)
{
    lua_settop(L, 3);
    cocos2d::UserDefault *self = (cocos2d::UserDefault *)xluacv_to_obj(L, 1, "cc.UserDefault");
    const char *arg1 = (const char *)xluacv_to_string(L, 2);
    const std::string arg2 = (const std::string)xluacv_to_std_string(L, 3);
    self->setStringForKey(arg1, arg2);
    return 0;
}

static int _cocos2d_UserDefault_flush(lua_State *L)
{
    lua_settop(L, 1);
    cocos2d::UserDefault *self = (cocos2d::UserDefault *)xluacv_to_obj(L, 1, "cc.UserDefault");
    self->flush();
    return 0;
}

static int _cocos2d_UserDefault_deleteValueForKey(lua_State *L)
{
    lua_settop(L, 2);
    cocos2d::UserDefault *self = (cocos2d::UserDefault *)xluacv_to_obj(L, 1, "cc.UserDefault");
    const char *arg1 = (const char *)xluacv_to_string(L, 2);
    self->deleteValueForKey(arg1);
    return 0;
}

static int _cocos2d_UserDefault_getInstance(lua_State *L)
{
    lua_settop(L, 0);
    
    cocos2d::UserDefault *ret = (cocos2d::UserDefault *)cocos2d::UserDefault::getInstance();
    return xluacv_push_obj(L, ret, "cc.UserDefault");
}

static int _cocos2d_UserDefault_getXMLFilePath(lua_State *L)
{
    lua_settop(L, 0);
    
    const std::string ret = (const std::string)cocos2d::UserDefault::getXMLFilePath();
    return xluacv_push_std_string(L, ret);
}

static int _cocos2d_UserDefault_isXMLFileExist(lua_State *L)
{
    lua_settop(L, 0);
    
    bool ret = (bool)cocos2d::UserDefault::isXMLFileExist();
    return xluacv_push_bool(L, ret);
}

static int luaopen_cocos2d_UserDefault(lua_State *L)
{
    xluacls_class(L, "cc.UserDefault", nullptr);
    xluacls_setfunc(L, "getBoolForKey", _cocos2d_UserDefault_getBoolForKey);
    xluacls_setfunc(L, "getIntegerForKey", _cocos2d_UserDefault_getIntegerForKey);
    xluacls_setfunc(L, "getFloatForKey", _cocos2d_UserDefault_getFloatForKey);
    xluacls_setfunc(L, "getDoubleForKey", _cocos2d_UserDefault_getDoubleForKey);
    xluacls_setfunc(L, "getStringForKey", _cocos2d_UserDefault_getStringForKey);
    xluacls_setfunc(L, "setBoolForKey", _cocos2d_UserDefault_setBoolForKey);
    xluacls_setfunc(L, "setIntegerForKey", _cocos2d_UserDefault_setIntegerForKey);
    xluacls_setfunc(L, "setFloatForKey", _cocos2d_UserDefault_setFloatForKey);
    xluacls_setfunc(L, "setDoubleForKey", _cocos2d_UserDefault_setDoubleForKey);
    xluacls_setfunc(L, "setStringForKey", _cocos2d_UserDefault_setStringForKey);
    xluacls_setfunc(L, "flush", _cocos2d_UserDefault_flush);
    xluacls_setfunc(L, "deleteValueForKey", _cocos2d_UserDefault_deleteValueForKey);
    xluacls_setfunc(L, "getInstance", _cocos2d_UserDefault_getInstance);
    xluacls_setfunc(L, "getXMLFilePath", _cocos2d_UserDefault_getXMLFilePath);
    xluacls_setfunc(L, "isXMLFileExist", _cocos2d_UserDefault_isXMLFileExist);
    xluacls_initmetafunc(L);
    
    xluacls_newclassproxy(L);
    
    return 1;
}

static int _cocos2d_Ref___gc(lua_State *L)
{
    return xluacls_ccobjgc(L);
}

static int _cocos2d_Ref_getReferenceCount(lua_State *L)
{
    lua_settop(L, 1);
    cocos2d::Ref *self = (cocos2d::Ref *)xluacv_to_ccobj(L, 1, "cc.Ref");
    unsigned int ret = (unsigned int)self->getReferenceCount();
    return xluacv_push_uint(L, ret);
}

static int luaopen_cocos2d_Ref(lua_State *L)
{
    xluacls_class(L, "cc.Ref", nullptr);
    xluacls_setfunc(L, "__gc", _cocos2d_Ref___gc);
    xluacls_property(L, "referenceCount", _cocos2d_Ref_getReferenceCount, nullptr);
    xluacls_initmetafunc(L);
    
    xluacls_newclassproxy(L);
    
    return 1;
}

static int _cocos2d_Director_getInstance(lua_State *L)
{
    lua_settop(L, 0);
    
    cocos2d::Director *ret = (cocos2d::Director *)cocos2d::Director::getInstance();
    return xluacv_push_ccobj(L, ret, "cc.Director");
}

static int _cocos2d_Director_getRunningScene(lua_State *L)
{
    lua_settop(L, 1);
    cocos2d::Director *self = (cocos2d::Director *)xluacv_to_ccobj(L, 1, "cc.Director");
    cocos2d::Scene *ret = (cocos2d::Scene *)self->getRunningScene();
    return xluacv_push_ccobj(L, ret, "cc.Scene");
}

static int luaopen_cocos2d_Director(lua_State *L)
{
    xluacls_class(L, "cc.Director", "cc.Ref");
    xluacls_setfunc(L, "getInstance", _cocos2d_Director_getInstance);
    xluacls_property(L, "runningScene", _cocos2d_Director_getRunningScene, nullptr);
    xluacls_initmetafunc(L);
    
    xluacls_newclassproxy(L);
    
    return 1;
}

static int _cocos2d_Node_create(lua_State *L)
{
    lua_settop(L, 0);
    
    cocos2d::Node *ret = (cocos2d::Node *)cocos2d::Node::create();
    return xluacv_push_ccobj(L, ret, "cc.Node");
}

static int _cocos2d_Node_addChild1(lua_State *L)
{
    lua_settop(L, 2);
    cocos2d::Node *self = (cocos2d::Node *)xluacv_to_ccobj(L, 1, "cc.Node");
    cocos2d::Node *arg1 = (cocos2d::Node *)xluacv_to_ccobj(L, 2, "cc.Node");
    self->addChild(arg1);
    return 0;
}

static int _cocos2d_Node_addChild2(lua_State *L)
{
    lua_settop(L, 3);
    cocos2d::Node *self = (cocos2d::Node *)xluacv_to_ccobj(L, 1, "cc.Node");
    cocos2d::Node *arg1 = (cocos2d::Node *)xluacv_to_ccobj(L, 2, "cc.Node");
    int arg2 = (int)xluacv_to_int(L, 3);
    self->addChild(arg1, arg2);
    return 0;
}

static int _cocos2d_Node_addChild3(lua_State *L)
{
    lua_settop(L, 4);
    cocos2d::Node *self = (cocos2d::Node *)xluacv_to_ccobj(L, 1, "cc.Node");
    cocos2d::Node *arg1 = (cocos2d::Node *)xluacv_to_ccobj(L, 2, "cc.Node");
    int arg2 = (int)xluacv_to_int(L, 3);
    int arg3 = (int)xluacv_to_int(L, 4);
    self->addChild(arg1, arg2, arg3);
    return 0;
}

static int _cocos2d_Node_addChild4(lua_State *L)
{
    lua_settop(L, 4);
    cocos2d::Node *self = (cocos2d::Node *)xluacv_to_ccobj(L, 1, "cc.Node");
    cocos2d::Node *arg1 = (cocos2d::Node *)xluacv_to_ccobj(L, 2, "cc.Node");
    int arg2 = (int)xluacv_to_int(L, 3);
    const std::string arg3 = (const std::string)xluacv_to_std_string(L, 4);
    self->addChild(arg1, arg2, arg3);
    return 0;
}

static int _cocos2d_Node_addChild(lua_State *L)
{
    int num_args = lua_gettop(L) - 1;

    if (num_args == 1) {
        // if (xluacv_is_ccobj(L, 2, "cc.Node")) {
            return _cocos2d_Node_addChild1(L);
        // }
    }
    
    if (num_args == 2) {
        // if (xluacv_is_ccobj(L, 2, "cc.Node") && xluacv_is_int(L, 3)) {
            return _cocos2d_Node_addChild2(L);
        // }
    }
    
    if (num_args == 3) {
        if (xluacv_is_ccobj(L, 2, "cc.Node") && xluacv_is_int(L, 3) && xluacv_is_int(L, 4)) {
            return _cocos2d_Node_addChild3(L);
        }
        
        // if (xluacv_is_ccobj(L, 2, "cc.Node") && xluacv_is_int(L, 3) && xluacv_is_std_string(L, 4)) {
            return _cocos2d_Node_addChild4(L);
        // }
    }

    luaL_error(L, "method 'cocos2d::Node::addChild' not support '%d' arguments", num_args);

    return 0;
}

static int _cocos2d_Node_getChildByTag(lua_State *L)
{
    lua_settop(L, 2);
    cocos2d::Node *self = (cocos2d::Node *)xluacv_to_ccobj(L, 1, "cc.Node");
    int arg1 = (int)xluacv_to_int(L, 2);
    cocos2d::Node *ret = (cocos2d::Node *)self->getChildByTag(arg1);
    return xluacv_push_ccobj(L, ret, "cc.Node");
}

static int _cocos2d_Node_removeFromParent(lua_State *L)
{
    lua_settop(L, 1);
    cocos2d::Node *self = (cocos2d::Node *)xluacv_to_ccobj(L, 1, "cc.Node");
    self->removeFromParent();
    return 0;
}

static int _cocos2d_Node_removeFromParentAndCleanup(lua_State *L)
{
    lua_settop(L, 2);
    cocos2d::Node *self = (cocos2d::Node *)xluacv_to_ccobj(L, 1, "cc.Node");
    bool arg1 = (bool)xluacv_to_bool(L, 2);
    self->removeFromParentAndCleanup(arg1);
    return 0;
}

static int _cocos2d_Node_removeChild(lua_State *L)
{
    lua_settop(L, 3);
    cocos2d::Node *self = (cocos2d::Node *)xluacv_to_ccobj(L, 1, "cc.Node");
    cocos2d::Node *arg1 = (cocos2d::Node *)xluacv_to_ccobj(L, 2, "cc.Node");
    bool arg2 = (bool)xluacv_opt_bool(L, 3, true);
    self->removeChild(arg1, arg2);
    return 0;
}

static int _cocos2d_Node_removeChildByTag(lua_State *L)
{
    lua_settop(L, 3);
    cocos2d::Node *self = (cocos2d::Node *)xluacv_to_ccobj(L, 1, "cc.Node");
    int arg1 = (int)xluacv_to_int(L, 2);
    bool arg2 = (bool)xluacv_opt_bool(L, 3, true);
    self->removeChildByTag(arg1, arg2);
    return 0;
}

static int _cocos2d_Node_removeChildByName(lua_State *L)
{
    lua_settop(L, 3);
    cocos2d::Node *self = (cocos2d::Node *)xluacv_to_ccobj(L, 1, "cc.Node");
    const std::string arg1 = (const std::string)xluacv_to_std_string(L, 2);
    bool arg2 = (bool)xluacv_opt_bool(L, 3, true);
    self->removeChildByName(arg1, arg2);
    return 0;
}

static int _cocos2d_Node_removeAllChildren(lua_State *L)
{
    lua_settop(L, 1);
    cocos2d::Node *self = (cocos2d::Node *)xluacv_to_ccobj(L, 1, "cc.Node");
    self->removeAllChildren();
    return 0;
}

static int _cocos2d_Node_removeAllChildrenWithCleanup(lua_State *L)
{
    lua_settop(L, 2);
    cocos2d::Node *self = (cocos2d::Node *)xluacv_to_ccobj(L, 1, "cc.Node");
    bool arg1 = (bool)xluacv_to_bool(L, 2);
    self->removeAllChildrenWithCleanup(arg1);
    return 0;
}

static int _cocos2d_Node_reorderChild(lua_State *L)
{
    lua_settop(L, 3);
    cocos2d::Node *self = (cocos2d::Node *)xluacv_to_ccobj(L, 1, "cc.Node");
    cocos2d::Node *arg1 = (cocos2d::Node *)xluacv_to_ccobj(L, 2, "cc.Node");
    int arg2 = (int)xluacv_to_int(L, 3);
    self->reorderChild(arg1, arg2);
    return 0;
}

static int _cocos2d_Node_sortAllChildren(lua_State *L)
{
    lua_settop(L, 1);
    cocos2d::Node *self = (cocos2d::Node *)xluacv_to_ccobj(L, 1, "cc.Node");
    self->sortAllChildren();
    return 0;
}

static int _cocos2d_Node_setPosition(lua_State *L)
{
    lua_settop(L, 3);
    cocos2d::Node *self = (cocos2d::Node *)xluacv_to_ccobj(L, 1, "cc.Node");
    float arg1 = (float)xluacv_to_number(L, 2);
    float arg2 = (float)xluacv_to_number(L, 3);
    self->setPosition(arg1, arg2);
    return 0;
}

static int luaopen_cocos2d_Node(lua_State *L)
{
    xluacls_class(L, "cc.Node", "cc.Ref");
    xluacls_setfunc(L, "create", _cocos2d_Node_create);
    xluacls_setfunc(L, "addChild", _cocos2d_Node_addChild);
    xluacls_setfunc(L, "getChildByTag", _cocos2d_Node_getChildByTag);
    xluacls_setfunc(L, "removeFromParent", _cocos2d_Node_removeFromParent);
    xluacls_setfunc(L, "removeFromParentAndCleanup", _cocos2d_Node_removeFromParentAndCleanup);
    xluacls_setfunc(L, "removeChild", _cocos2d_Node_removeChild);
    xluacls_setfunc(L, "removeChildByTag", _cocos2d_Node_removeChildByTag);
    xluacls_setfunc(L, "removeChildByName", _cocos2d_Node_removeChildByName);
    xluacls_setfunc(L, "removeAllChildren", _cocos2d_Node_removeAllChildren);
    xluacls_setfunc(L, "removeAllChildrenWithCleanup", _cocos2d_Node_removeAllChildrenWithCleanup);
    xluacls_setfunc(L, "reorderChild", _cocos2d_Node_reorderChild);
    xluacls_setfunc(L, "sortAllChildren", _cocos2d_Node_sortAllChildren);
    xluacls_setfunc(L, "setPosition", _cocos2d_Node_setPosition);
    xluacls_initmetafunc(L);
    
    xluacls_newclassproxy(L);
    
    return 1;
}

static int _cocos2d_Sprite_create(lua_State *L)
{
    lua_settop(L, 1);
    const std::string arg1 = (const std::string)xluacv_to_std_string(L, 1);
    cocos2d::Sprite *ret = (cocos2d::Sprite *)cocos2d::Sprite::create(arg1);
    return xluacv_push_ccobj(L, ret, "cc.Sprite");
}

static int luaopen_cocos2d_Sprite(lua_State *L)
{
    xluacls_class(L, "cc.Sprite", "cc.Node");
    xluacls_setfunc(L, "create", _cocos2d_Sprite_create);
    xluacls_initmetafunc(L);
    
    xluacls_newclassproxy(L);
    
    return 1;
}

static int luaopen_cocos2d_Scene(lua_State *L)
{
    xluacls_class(L, "cc.Scene", "cc.Node");
    
    xluacls_initmetafunc(L);
    
    xluacls_newclassproxy(L);
    
    return 1;
}

int luaopen_cocos2d(lua_State *L)
{
    xlua_require(L, "cc.UserDefault", luaopen_cocos2d_UserDefault);
    xlua_require(L, "cc.Ref", luaopen_cocos2d_Ref);
    xlua_require(L, "cc.Director", luaopen_cocos2d_Director);
    xlua_require(L, "cc.Node", luaopen_cocos2d_Node);
    xlua_require(L, "cc.Sprite", luaopen_cocos2d_Sprite);
    xlua_require(L, "cc.Scene", luaopen_cocos2d_Scene);
    return 0;
}