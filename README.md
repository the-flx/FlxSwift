[![License](https://img.shields.io/badge/License-Apache_2.0-green.svg)](https://opensource.org/licenses/Apache-2.0)
[![Release](https://img.shields.io/github/tag/the-flx/FlxSwift.svg?label=release&logo=github)](https://github.com/the-flx/FlxSwift/releases/latest)

# Flx
> Rewrite emacs-flx in Swift

[![CI](https://github.com/the-flx/FlxSwift/actions/workflows/test.yml/badge.svg)](https://github.com/the-flx/FlxSwift/actions/workflows/test.yml)

## 🔨 Usage

```swift
import Flx

print(Flx.score(str: "switch-to-buffer", query: "stb")?.score)  // 237
```

## 🛠️ Development

To run tests:

```sh
$ swift build
$ swift test
```

## 🔗 Links

- [Creating and Publishing Swift Packages (Swift Package Manager)](https://www.youtube.com/watch?v=4Rxuc4BcW8o&ab_channel=azamsharp)

## ⚜ License

Copyright 2024-present Jen-Chieh Shen.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

See [`LICENSE`](./LICENSE) for details.

