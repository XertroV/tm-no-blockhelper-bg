const string HelperPageName = "UIModule_Race_BlockHelper";
const string HelperFrameId = "Race_BlockHelper";
const string EventName = "BlockHelper_Event_GameplaySpecial";

const string DisplayMsgLabelId = "Race_DisplayMessage";

void CMapLoop() {
    auto app = cast<CGameManiaPlanet>(GetApp());
    auto net = app.Network;
    while (true) {
        yield();
        while (net.ClientManiaAppPlayground is null) yield();
        AwaitGetMLObjs();
        while (net.ClientManiaAppPlayground !is null) yield();
        @HelperFrame = null;
        count = 0;
    }
}


CGameManialinkFrame@ HelperFrame = null;
uint count = 0;

void AwaitGetMLObjs() {
    print('AwaitGetMLObjs');
    auto net = cast<CTrackManiaNetwork>(GetApp().Network);
    if (net.ClientManiaAppPlayground is null) throw('null cmap');
    auto cmap = net.ClientManiaAppPlayground;
    while (net.ClientManiaAppPlayground !is null && cmap.UILayers.Length < 7) yield();
    if (net.ClientManiaAppPlayground is null) return;
    count = 0;
    while (HelperFrame is null) {
        sleep(100);
        if (net.ClientManiaAppPlayground is null) return;
        for (uint i = 0; i < cmap.UILayers.Length; i++) {
            auto layer = cmap.UILayers[i];
            if (!layer.IsLocalPageScriptRunning || !layer.IsVisible || layer.LocalPage is null) continue;
            auto frame = cast<CGameManialinkFrame>(layer.LocalPage.GetFirstChild(HelperFrameId));
            if (frame is null) continue;
            @HelperFrame = frame;
            break;
        }
        count++;
        if (count > 50) {
            warn("Could not find block helper frame");
            return;
        }
    }
    startnew(UpdateHelperFrameBg);
}

void UpdateHelperFrameBg() {
    if (HelperFrame is null) throw('unexpected null HelperFrame');
    if (HelperFrame.Controls.Length < 2) throw('helper frame controls < 2');
    auto label = HelperFrame.Controls[0];
    auto frameBg = cast<CGameManialinkFrame>(HelperFrame.Controls[1]);
    if (frameBg is null) throw('null frameBg');
    frameBg.RelativePosition_V3 = vec2(1000);
    print('frameBg done');
}
