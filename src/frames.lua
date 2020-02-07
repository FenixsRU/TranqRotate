local TranqRotate = select(2, ...)

function TranqRotate:createMainFrame()
    TranqRotate.mainFrame = CreateFrame("Frame", 'mainFrame', UIParent)
    TranqRotate.mainFrame:SetWidth(120)
    TranqRotate.mainFrame:SetHeight(40 + TranqRotate.constants.titleBarHeight)
    TranqRotate.mainFrame:Show()

    TranqRotate.mainFrame:RegisterForDrag("LeftButton")
    TranqRotate.mainFrame:SetClampedToScreen(true)
    TranqRotate.mainFrame:SetScript("OnDragStart", function() TranqRotate.mainFrame:StartMoving() end)

    TranqRotate.mainFrame:SetScript(
        "OnDragStop",
        function()
            local config, meh = TranqRotate.db.profile
            TranqRotate.mainFrame:StopMovingOrSizing()
            config.point, meh , config.relativePoint, config.x, config.y = TranqRotate.mainFrame:GetPoint()
        end
    )
end

function TranqRotate:createTitleFrame()
    TranqRotate.mainFrame.titleFrame = CreateFrame("Frame", 'rotationFrame', TranqRotate.mainFrame)
    TranqRotate.mainFrame.titleFrame:SetPoint('TOPLEFT')
    TranqRotate.mainFrame.titleFrame:SetPoint('TOPRIGHT')
    TranqRotate.mainFrame.titleFrame:SetHeight(TranqRotate.constants.titleBarHeight)

    TranqRotate.mainFrame.titleFrame.texture = TranqRotate.mainFrame.titleFrame:CreateTexture(nil, "BACKGROUND")
    TranqRotate.mainFrame.titleFrame.texture:SetColorTexture(TranqRotate.colors.darkGreen:GetRGB())
    TranqRotate.mainFrame.titleFrame.texture:SetAllPoints()

    TranqRotate.mainFrame.titleFrame.text = TranqRotate.mainFrame.titleFrame:CreateFontString(nil, "ARTWORK")
    TranqRotate.mainFrame.titleFrame.text:SetFont("Fonts\\ARIALN.ttf", 12)
    TranqRotate.mainFrame.titleFrame.text:SetShadowColor(0,0,0,0.5)
    TranqRotate.mainFrame.titleFrame.text:SetShadowOffset(1,-1)
    TranqRotate.mainFrame.titleFrame.text:SetPoint("LEFT",5,0)
    TranqRotate.mainFrame.titleFrame.text:SetText('TranqRotate')
    TranqRotate.mainFrame.titleFrame.text:SetTextColor(1,1,1,1)
end

function TranqRotate:createButtons()

    local buttons = {
        {
            ['texture'] = 'Interface/GossipFrame/BinderGossipIcon',
            ['callback'] = TranqRotate.openSettings
        },
        {
            ['texture'] = 'Interface/Buttons/UI-RefreshButton',
            ['callback'] = TranqRotate.resetRotation
        },
        {
            ['texture'] = 'Interface/Buttons/UI-GuildButton-MOTD-Up',
            ['callback'] = TranqRotate.broadcastToRaid
        },
    }

    local position = 5

    for key, button in pairs(buttons) do
        TranqRotate:createButton(position, button.texture, button.callback )
        position = position + 13
    end
end


function TranqRotate:createButton(position, texture, callback)

    local button = CreateFrame("Button", nil, TranqRotate.mainFrame.titleFrame)
    button:SetPoint('RIGHT', -position, 0)
    button:SetWidth(10)
    button:SetHeight(10)

    local normal = button:CreateTexture()
    normal:SetTexture(texture)
    normal:SetAllPoints()
    button:SetNormalTexture(normal)

    local highlight = button:CreateTexture()
    highlight:SetTexture(texture)
    highlight:SetAllPoints()
    button:SetHighlightTexture(highlight)

    button:SetScript("OnClick", callback)
end

function TranqRotate:createRotationFrame()
    TranqRotate.mainFrame.rotationFrame = CreateFrame("Frame", 'rotationFrame', TranqRotate.mainFrame)
    TranqRotate.mainFrame.rotationFrame:SetPoint('LEFT')
    TranqRotate.mainFrame.rotationFrame:SetPoint('RIGHT')
    TranqRotate.mainFrame.rotationFrame:SetPoint('TOP', 0, -TranqRotate.constants.titleBarHeight)
    TranqRotate.mainFrame.rotationFrame:SetHeight(20)

    TranqRotate.mainFrame.rotationFrame.texture = TranqRotate.mainFrame.rotationFrame:CreateTexture(nil, "BACKGROUND")
    TranqRotate.mainFrame.rotationFrame.texture:SetColorTexture(0,0,0,0.5)
    TranqRotate.mainFrame.rotationFrame.texture:SetAllPoints()
end

function TranqRotate:createBackupFrame()
    -- Backup frame
    TranqRotate.mainFrame.backupFrame = CreateFrame("Frame", 'backupFrame', TranqRotate.mainFrame)
    TranqRotate.mainFrame.backupFrame:SetPoint('TOPLEFT', TranqRotate.mainFrame.rotationFrame, 'BOTTOMLEFT', 0, 0)
    TranqRotate.mainFrame.backupFrame:SetPoint('TOPRIGHT', TranqRotate.mainFrame.rotationFrame, 'BOTTOMRIGHT', 0, 0)
    TranqRotate.mainFrame.backupFrame:SetHeight(20)

    TranqRotate.mainFrame.backupFrame.texture = TranqRotate.mainFrame.backupFrame:CreateTexture(nil, "BACKGROUND")
    TranqRotate.mainFrame.backupFrame.texture:SetColorTexture(0,0,0,0.5)
    TranqRotate.mainFrame.backupFrame.texture:SetAllPoints()

    -- Visual separator
    TranqRotate.mainFrame.backupFrame.texture = TranqRotate.mainFrame.backupFrame:CreateTexture(nil, "BACKGROUND")
    TranqRotate.mainFrame.backupFrame.texture:SetColorTexture(0.8,0.8,0.8,0.8)
    TranqRotate.mainFrame.backupFrame.texture:SetHeight(1)
    TranqRotate.mainFrame.backupFrame.texture:SetWidth(60)
    TranqRotate.mainFrame.backupFrame.texture:SetPoint('TOP')
end
