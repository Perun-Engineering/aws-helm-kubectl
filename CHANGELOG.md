# Changelog

All notable changes to this project will be documented in this file.

## [1.9.0](https://github.com/Perun-Engineering/aws-helm-kubectl/compare/v1.8.1...v1.9.0) (2025-10-03)

### Features

* arm runners for faster builds ([#16](https://github.com/Perun-Engineering/aws-helm-kubectl/issues/16)) ([5ba38a1](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/5ba38a1742e3b8c9b4aa1f0085b5cc48f63a7904))

### Bug Fixes

* dockerfile targetarch ([#18](https://github.com/Perun-Engineering/aws-helm-kubectl/issues/18)) ([2f9fe78](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/2f9fe78971aa0541b3a1e17c83ed35615eff5980))
* Matrix build ([#17](https://github.com/Perun-Engineering/aws-helm-kubectl/issues/17)) ([3931959](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/393195993a11e96120480a61bb0a077cd753f8be))

## [1.8.1](https://github.com/Perun-Engineering/aws-helm-kubectl/compare/v1.8.0...v1.8.1) (2025-10-03)

### Bug Fixes

* remove typo in Dockerfile ([#15](https://github.com/Perun-Engineering/aws-helm-kubectl/issues/15)) ([fd470a6](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/fd470a6fb3323d69f51e6423f2dae5663be6a482))

## [1.8.0](https://github.com/Perun-Engineering/aws-helm-kubectl/compare/v1.7.0...v1.8.0) (2025-10-03)

### Features

* bump versions for SOPS and aws-cli ([9155f95](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/9155f958566b1edabbdb6ebe41834e14f6d166f7))
* Bump versions, improve documentation, fix helm plugins ([#13](https://github.com/Perun-Engineering/aws-helm-kubectl/issues/13)) ([ab20fee](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/ab20fee89500e515ecb95eff97227dc5b57c7c5f))

### Bug Fixes

* docker build error ([#14](https://github.com/Perun-Engineering/aws-helm-kubectl/issues/14)) ([5997ea3](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/5997ea330ffe6a8cb901952834845234e03daced))
* install helm plugins for the user we are using ([6c009ae](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/6c009aeb550992d8a83ec90fd9b502504cda015b))

## [1.8.0](https://github.com/Perun-Engineering/aws-helm-kubectl/compare/v1.7.0...v1.8.0) (2025-10-03)

### Features

* Bump versions, improve documentation, fix helm plugins ([#13](https://github.com/Perun-Engineering/aws-helm-kubectl/issues/13)) ([ab20fee](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/ab20fee89500e515ecb95eff97227dc5b57c7c5f))

## [1.7.0](https://github.com/Perun-Engineering/aws-helm-kubectl/compare/v1.6.0...v1.7.0) (2025-09-19)

### Features

* Bump tools versions ([#11](https://github.com/Perun-Engineering/aws-helm-kubectl/issues/11)) ([c2f7476](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/c2f74768dbaf40b89134e429f778075b4c622fd1))

## [1.6.0](https://github.com/Perun-Engineering/aws-helm-kubectl/compare/v1.5.0...v1.6.0) (2025-08-19)

### Features

* update dockerfile configuration ([a8a50fc](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/a8a50fcf26b2c35d7f7bffc1e9818525fb60a10c))

## [1.5.0](https://github.com/Perun-Engineering/aws-helm-kubectl/compare/v1.4.0...v1.5.0) (2025-07-17)

### Features

* Update AWS CLI to latest version 2.27.53 ([9a886bd](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/9a886bd4a732140a61f8b4105f2f72bc0fc78641))

### Bug Fixes

* Add default values to Dockerfile ARG declarations ([053c1c1](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/053c1c1df6b0d1af6419ffa9e033577469e27a8c))

## [1.4.0](https://github.com/Perun-Engineering/aws-helm-kubectl/compare/v1.3.0...v1.4.0) (2025-07-17)

### Features

* Bump Kubernetes versions to 1.31.11, 1.23.7, 1.33.3 ([ad0e52e](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/ad0e52e0276cf55ced8d1143819cfabf0862c50f))
* downgrade Python from 3.13 to 3.12.11 ([4ff9df0](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/4ff9df048b9ff3d27b2b1cede1764e67e210aac6))
* downgrade Python to 3.11.13 for better compatibility ([be99ad4](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/be99ad4bb7c061e36f399b9d8bb23f293e806bde))
* improve CI workflows to test PR branches before merge ([b784251](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/b784251160da6b294b75c0662704a4f0cde8c982))
* migrate to perun-engineering org and add dual registry support ([2c1cbac](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/2c1cbac4affbacd3a77a41a43964396199238200))
* Optimize workflow and fix authentication issues ([f659f5c](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/f659f5c5c2d27c5d2d8809f0712b82801b1302cf))

### Bug Fixes

* add load: true to PR test workflow ([cd9f187](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/cd9f1874d5e17b8e25b5000c529604f4e7e285c6))
* Implement build-once, push-twice optimization ([ab720c1](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/ab720c1d9cb7c707470af11c1b760777f86b1b53))
* update workflows for repository migration and make security scans informational ([ac91ddd](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/ac91ddda749feaf4ba78f281077d60a6304e8885))
* Use lowercase repository name for GHCR ([e1ca68d](https://github.com/Perun-Engineering/aws-helm-kubectl/commit/e1ca68d421e4059e8d58bbe7962306beb6ec55db))

## [1.3.0](https://github.com/opsworks-co/aws-helm-kubectl/compare/v1.2.1...v1.3.0) (2025-01-15)

### Features

* Bump Alpine base image to the version 3.20.5 ([59cdc73](https://github.com/opsworks-co/aws-helm-kubectl/commit/59cdc733199ff25d1d7b96c7e884c816392c7999))
* Bump aws-cli to the version 2.23.0 ([861fbab](https://github.com/opsworks-co/aws-helm-kubectl/commit/861fbab93b3208a1eb2cecddd5a9d14a031bbd14))
* Bump Helm to the version 3.17.0 ([d2bc27a](https://github.com/opsworks-co/aws-helm-kubectl/commit/d2bc27a779fc6d42a6d56b90aed354308514bd48))
* Bump kubectl to the versions 1.29.13, 1.30.9, 1.31.5, 1.32.1 ([787e4a6](https://github.com/opsworks-co/aws-helm-kubectl/commit/787e4a6895d1ed3bd87850514f95077e217be129))

## [1.2.1](https://github.com/opsworks-co/aws-helm-kubectl/compare/v1.2.0...v1.2.1) (2025-01-08)

### Bug Fixes

* Bump Alpine base image to 3.20.4 ([d8630cb](https://github.com/opsworks-co/aws-helm-kubectl/commit/d8630cbc3f855c587ceb25c3b25e36bcec95ba17))

## [1.2.0](https://github.com/opsworks-co/aws-helm-kubectl/compare/v1.1.0...v1.2.0) (2024-12-13)

### Features

* Revert to Alpine 3.20.3 because of build errors of aws-cli on the latest 3.21.0 ([#32](https://github.com/opsworks-co/aws-helm-kubectl/issues/32)) ([2699342](https://github.com/opsworks-co/aws-helm-kubectl/commit/269934251fe6ff0c54813cf39b7fc1f9f287494e))

## [1.1.0](https://github.com/opsworks-co/aws-helm-kubectl/compare/v1.0.0...v1.1.0) (2024-12-13)

### Features

* **ci:** Fix building docker images ([#31](https://github.com/opsworks-co/aws-helm-kubectl/issues/31)) ([378cbe9](https://github.com/opsworks-co/aws-helm-kubectl/commit/378cbe9fce7d4be75a7d68aa57d47fc0066b8304))
* **ci:** Fix building images ([#30](https://github.com/opsworks-co/aws-helm-kubectl/issues/30)) ([6bec3dd](https://github.com/opsworks-co/aws-helm-kubectl/commit/6bec3dd9e76e00b2e3bedf74b338d25aca708d01))

## 1.0.0 (2024-12-13)

### Features

* Initial version ([15d0a51](https://github.com/opsworks-co/aws-helm-kubectl/commit/15d0a51ed0257e9f9bd3b187eea27d8019f76819))
