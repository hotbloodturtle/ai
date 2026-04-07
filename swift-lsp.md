# Swift LSP

> Swift 개발자를 위한 Language Server Protocol 통합 플러그인

## 소개

Swift LSP는 Swift 언어 서버(sourcekit-lsp)를 Claude Code에 통합하여 Swift/iOS/macOS 프로젝트에서 심볼 분석, 자동완성, 진단 기능을 제공하는 플러그인이다.
Apple 공식 sourcekit-lsp를 백엔드로 사용하며, Xcode가 설치된 macOS 환경에서 동작한다.

## 주요 기능

- Swift 코드 심볼 분석 및 탐색
- 타입 정보, 함수 시그니처 자동 인식
- 컴파일 에러/경고 진단
- `go to definition`, `find references` 지원
- SwiftPM(Swift Package Manager) 및 Xcode 프로젝트 인식

## 공식 링크

- Claude Code 플러그인 마켓플레이스: `claude-plugins-official`
- Apple sourcekit-lsp: https://github.com/apple/sourcekit-lsp

## 설치

```bash
# claude-plugins-official 마켓플레이스에서 설치
/plugin install swift-lsp
```

## 참고 사항

- macOS 전용 (Xcode 또는 Xcode Command Line Tools 필요)
- Swift 프로젝트(SwiftPM, Xcode)에서만 활성화됨
- 일반 웹/백엔드 개발에는 불필요 (Swift 프로젝트 작업 시에만 유용)
