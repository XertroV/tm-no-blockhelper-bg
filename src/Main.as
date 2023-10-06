void Main() {
    startnew(CMapLoop);
}

void OnDestroyed() { Unload(); }
void OnDisabled() { Unload(); }
void Unload() {
    auto app = GetApp();
    if (app is null || app.CurrentPlayground is null) @HelperFrame = null;
    if (HelperFrame is null) return;
    auto frameBg = cast<CGameManialinkFrame>(HelperFrame.Controls[1]);
    if (frameBg is null) return;
    frameBg.RelativePosition_V3 = vec2(0);
}

void OnEnabled() {
    try {
        AwaitGetMLObjs();
    } catch {}
}
