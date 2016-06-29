
local ComponentBase = cc.import(".ComponentBase")
local EditBoxComponent = cc.class("cc.EditBox", ComponentBase)

local ccrect = cc.rect
local EditBox = ccui.EditBox or cc.EditBox
local Scale9Sprite = ccui.Scale9Sprite or cc.Scale9Sprite

function EditBoxComponent:ctor(asset, assets)
    EditBoxComponent.super.ctor(self)

    local bg
    if asset["_N$backgroundImage"] then
        local uuid = asset["_N$backgroundImage"]["__uuid__"]
        local spriteFrameAsset = assets:getAsset(uuid)
        local spriteFrame = assets:_createObject(spriteFrameAsset)
        local r = spriteFrameAsset["content"]["capInsets"]
        local capInsets = ccrect(r[1], r[2], r[3], r[4])
        bg = Scale9Sprite:createWithSpriteFrame(spriteFrame, capInsets)
    end

    local node = EditBox:create({width = 100, height = 20}, bg)

    local fontSize = asset["_N$fontSize"] or 24
    node:setFontSize(fontSize)

    if asset["_N$inputFlag"] then
        node:setInputFlag(asset["_N$inputFlag"])
    end
    if asset["_N$inputMode"] then
        node:setInputMode(asset["_N$inputMode"])
    end
    if asset["_N$maxLength"] then
        node:setMaxLength(asset["_N$maxLength"])
    end
    if asset["_N$fontColor"] then
        node:setFontColor(asset["_N$fontColor"])
    end
    self.node = node
end

function EditBoxComponent:onLoad(target)
    local node = self.node
    target:addChild(node)
    node:setContentSize(target.contentSize)
    node:setColor(target:getColor())
    node:setPosition(0, 0)
    local ap = target.__anchorPoint
    if not ap then
        ap = {x = 0.5, y = 0.5}
    end
    node:setAnchorPoint(ap)
    target:setAnchorPoint(ap)
end

function EditBoxComponent:onDestroy(target)
    self.node = nil
end

return EditBoxComponent