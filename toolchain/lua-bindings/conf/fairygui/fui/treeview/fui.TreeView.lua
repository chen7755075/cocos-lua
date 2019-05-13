local cls = class()
cls.CPPCLS = "fairygui::TreeView"
cls.LUACLS = "fui.TreeView"
cls.SUPERCLS = "fui.UIEventDispatcher"
cls.funcs [[
    static TreeView* create(@ref(single list) GList* list)
    @ref(single list) GList* getList()
    @ref(single rootNode) TreeNode* getRootNode()

    TreeNode* getSelectedNode()
    void addSelection(TreeNode* node, bool scrollItToView = false)
    void removeSelection(TreeNode* node)
    void clearSelection()

    int getNodeIndex(TreeNode* node)
    void updateNode(TreeNode* node)
    void expandAll(TreeNode* folderNode)
    void collapseAll(TreeNode* folderNode)
]]

cls.func('getSelection', [[
{
    lua_settop(L, 2);

    fairygui::GList *self = (fairygui::GList *)olua_toobj(L, 1, "fui.GList");
    std::vector<int> selections;
    self->getSelection(selections);
    int idx = 1;
    lua_createtable(L, (int)selections.size(), 0);
    for (auto v : selections) {
        lua_pushinteger(L, v);
        lua_rawseti(L, -2, idx++);
    }

    return 1;
}]])

cls.props [[
    list
    rootNode
    selectedNode
    selection
]]

cls.vars [[
    std::function<GComponent*(TreeNode* node)> treeNodeCreateCell;
    std::function<void(TreeNode* node)> treeNodeRender;
    std::function<void(TreeNode* node, bool expand)> treeNodeWillExpand;
]]

cls.inject('create', {
    AFTER = [[
        olua_push_cppobj<fairygui::TreeNode>(L, ret->getRootNode(), "fui.TreeNode");
        olua_singleref(L, -2, "rootNode", -1);
        lua_pop(L, 1);
    ]]
})

-- std::function<GComponent*(TreeNode* node)> treeNodeCreateCell;
cls.inject('treeNodeCreateCell', {
    CALLBACK_AFTER = [[
        olua_push_cppobj<fairygui::TreeNode>(L, arg1, "fui.TreeNode");
        olua_singleref(L, -1, "cell", -2);
        lua_pop(L, 1);
    ]]
})

return cls