window.OMAEROUTE_CONFIG = {
  // Kakao Developers에서 발급한 JavaScript 키입니다.
  kakaoJavaScriptKey: "",
  // 로컬 서버의 기상청 프록시입니다. 인증키는 브라우저가 아닌 .env에 보관합니다.
  kmaWeatherProxyUrl: "/api/weather",
  // 여행 미리보기 영상을 생성/조회하는 로컬 서버 엔드포인트입니다.
  routeVideoProxyUrl: "/api/route-video",
  // 정적 호스팅에서만 쓰는 레거시 직접 호출 옵션입니다. 키 노출 위험 때문에 비워두세요.
  kmaServiceKey: "",
  // AI 컨시어지 팁·AI 도슨트 채팅(Gemini)을 중계하는 로컬 서버 엔드포인트입니다. 인증키는 브라우저가 아닌 .env에 보관합니다.
  geminiProxyUrl: "",
};