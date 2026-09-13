import Flutter
import UIKit
import NidThirdPartyLogin

// 카카오 로그인(kakao_flutter_sdk_auth)은 여기서 따로 안 건드린다 — 그 플러그인이
// `FlutterSceneLifeCycleDelegate` 로 스스로를 등록해서 콜백 URL을 알아서 받는다
// (네이버 SDK 는 그런 자동 등록이 없는 순수 네이티브 SDK 라 여기서 직접 넘겨줘야 한다).
class SceneDelegate: FlutterSceneDelegate {

  override func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    for context in URLContexts {
      _ = NidOAuth.shared.handleURL(context.url)
    }
    super.scene(scene, openURLContexts: URLContexts)
  }

}
