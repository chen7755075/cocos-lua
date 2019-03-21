local M = {}

local cls = class(M)
cls.CPPCLS = 'spEventType'
cls.LUACLS = 'sp.EventType'
cls.enums [[
    SP_ANIMATION_START
    SP_ANIMATION_INTERRUPT
    SP_ANIMATION_END
    SP_ANIMATION_COMPLETE
    SP_ANIMATION_DISPOSE
    SP_ANIMATION_EVENT
]]

local cls = class(M)
cls.CPPCLS = 'spTrackEntry'
cls.LUACLS = 'sp.TrackEntry'

local cls = class(M)
cls.CPPCLS = 'spSkeletonData'
cls.LUACLS = 'sp.SkeletonData'

local cls = class(M)
cls.CPPCLS = 'spAnimation'
cls.LUACLS = 'sp.Animation'
cls.vars [[
    @readonly const char* name;
    @readonly float duration;
]]

local cls = class(M)
cls.CPPCLS = 'spAtlas'
cls.LUACLS = 'sp.Atlas'

local cls = class(M)
cls.CPPCLS = 'spEvent'
cls.LUACLS = 'sp.Event'

local cls = class(M)
cls.CPPCLS = 'spAnimationState'
cls.LUACLS = 'sp.AnimationState'

local cls = class(M)
cls.CPPCLS = 'spSkeleton'
cls.LUACLS = 'sp.Skeleton'

local cls = class(M)
cls.CPPCLS = 'spBone'
cls.LUACLS = 'sp.Bone'

local cls = class(M)
cls.CPPCLS = 'spSlot'
cls.LUACLS = 'sp.Slot'

local cls = class(M)
cls.CPPCLS = 'spAttachment'
cls.LUACLS = 'sp.Attachment'

local cls = class(M)
cls.CPPCLS = 'spVertexEffect'
cls.LUACLS = 'sp.VertexEffect'

local cls = class(M)
cls.CPPCLS = 'spAnimationStateData'
cls.LUACLS = 'sp.AnimationStateData'

return M