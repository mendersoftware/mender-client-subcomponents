# Mender Client next

| Repository | Version |
| --- | --- |
| [mender](https://github.com/mendersoftware/mender) | master |
| [mender-connect](https://github.com/mendersoftware/mender-connect) | master |
| [monitor-client](https://github.com/mendersoftware/monitor-client) | master |
| [mender-flash](https://github.com/mendersoftware/mender-flash) | master |
| [mender-configure-module](https://github.com/mendersoftware/mender-configure-module) | master |
| [mender-binary-delta](https://github.com/mendersoftware/mender-binary-delta) | master |
| [mender-container-modules](https://github.com/mendersoftware/mender-container-modules) | main |

## mender master (2026-02-20)

### master - 2026-02-20


#### Bug fixes


- Clear the inventory data hash on re-authentication
([MEN-7873](https://northerntech.atlassian.net/browse/MEN-7873)) ([9d1d579](https://github.com/mendersoftware/mender/commit/9d1d579c41137de0328f3a7b2b5de1f406643c1d))  by @jo-lund





- Retry polling on all errors
([MEN-7938](https://northerntech.atlassian.net/browse/MEN-7938)) ([45f88a1](https://github.com/mendersoftware/mender/commit/45f88a13e6eb1b7e8f4b8c65eba6cccb6030f2b7))  by @danielskinstad






  When implementing the backoff for errors when polling for deployment or
  submitting inventory, we added an exception for unauthorized errors.
  After looking at how it was done in Mender Client 3, we discovered
  that such an exception was not present there, and that the backoff
  should be triggered for all types of errors.
- Fix Mender client getting stuck after failure in sync state
([MEN-7900](https://northerntech.atlassian.net/browse/MEN-7900)) ([a97eb04](https://github.com/mendersoftware/mender/commit/a97eb04c87e5baab49bbece6f7646505edbceb23))  by @lluiscampos






  From the code point, the issue was that the re-scheduling of new polls
  for updates or inventory were done from the states _after_ the sync
  state, so unless the state machine reached that point the new polls
  would not be scheduled.
  
  Fix by creating two new states, that just do the re-scheduling, between
  idle and sync. Note that the timer(s) have now been moved to the context
  object so that it can be accessed from multiple states (namely, update
  polling and submit inventory states which would need to manipulate the
  timer for exponential back-off retries.
- Compile with Boost 1.87
([MEN-8051](https://northerntech.atlassian.net/browse/MEN-8051)) ([03f52ba](https://github.com/mendersoftware/mender/commit/03f52ba5f75f6163d56a96ff90a0a48c21667413))  by @jo-lund





- Fix deployment on 32 bit systems when rootfs is larger than 4Gb
([MEN-8062](https://northerntech.atlassian.net/browse/MEN-8062)) ([8ba599b](https://github.com/mendersoftware/mender/commit/8ba599b6ec48b7be9f4e5181593ec8c34d78b271))  by @jo-lund





- Use EscapeString when generating JSON for supplied artifact data
([MEN-7974](https://northerntech.atlassian.net/browse/MEN-7974)) ([d74fba3](https://github.com/mendersoftware/mender/commit/d74fba313f3131121c9cc1a8a8e6462691658b3b))  by @jo-lund





- Inventory-geo appears to hang while wget retries many times
 ([dd881e8](https://github.com/mendersoftware/mender/commit/dd881e8789c1499c76bf6254d9e6488f9e7ff104))  by @deligatedgeek




- Clear response buffer before every HTTP request
([MEN-8554](https://northerntech.atlassian.net/browse/MEN-8554)) ([fc38f8c](https://github.com/mendersoftware/mender/commit/fc38f8ca34f185e89d56f3a15e78d8d32d877635))  by @vpodzime






  Otherwise leftover trailing bytes from a previous response may be
  parsed as a beginning of the new response resulting in HTTP
  parsing errors.
- Make mender-inventory-geo work with busybox.wget
([MEN-8548](https://northerntech.atlassian.net/browse/MEN-8548)) ([033635a](https://github.com/mendersoftware/mender/commit/033635a3eccdd4123dc86b82324ced32bd5f6dd6))  by @michalkopczan




- Use /proc/cmdline for root device detection instead of stat in rootfs update module
 ([f822970](https://github.com/mendersoftware/mender/commit/f82297049b44fc40690f05920c9881aea3625417))  by @adbjo





- Add explicit check and handling for aborted deployments
([ME-527](https://northerntech.atlassian.net/browse/ME-527)) ([2f53d85](https://github.com/mendersoftware/mender/commit/2f53d853692da5e28ce6bde123a89cd9501e075c))  by @danielskinstad




- Add timeout to prevent hanging downloads on connection loss
([MEN-8717](https://northerntech.atlassian.net/browse/MEN-8717)) ([1b51930](https://github.com/mendersoftware/mender/commit/1b519306b97cdb5e0a8228f75f8f16c0164ed280))  by @danielskinstad






  If network connection is lost while downloading an artifact, the client
  can hang when calling `beast::http::async_read_some` in `AsyncReadNextBodyPart`.
  Implement an AsyncWait timer that triggers an error handler after 5 minutes.
- Make Update modules generators POSIX compatible
([MEN-8818](https://northerntech.atlassian.net/browse/MEN-8818)) ([1202183](https://github.com/mendersoftware/mender/commit/1202183572d34b72238f9a0cc5b84f47413e22b0))  by @lluiscampos






- Added warning for invalid NO_PROXY setting containing comma
([ME-586](https://northerntech.atlassian.net/browse/ME-586)) ([9286807](https://github.com/mendersoftware/mender/commit/92868077d1c2437c8203de32158d94f3ece422b2))  by @nickanderson






  While proxy variables are not perfectly standardized, if comma isn't
  correct, it's at least a common option, so a good warning will be helpful to users.
- Use correct variable for error message
 ([0a5acd1](https://github.com/mendersoftware/mender/commit/0a5acd153b9d18958ea33577fc9b1da9e95a2e0c))  by @thall






  Before wrong variable were used when constructing the error message.
- Sanitize Update Module paths - payload_type must not point outside of Update Modules' directory
([MEN-9027](https://northerntech.atlassian.net/browse/MEN-9027)) ([c76f042](https://github.com/mendersoftware/mender/commit/c76f042b381e640b7a8903da459bce9e8d8b8028))  by @michalkopczan




- Fix signature size checking
([MEN-9055](https://northerntech.atlassian.net/browse/MEN-9055)) ([f7a5968](https://github.com/mendersoftware/mender/commit/f7a59687c98e951f632d8744e56c31a62541880a))  by @elkoniu in #1853






  Follwoing the bug report - signature size we are processing
  shall be exact 64 bytes. Other size than that should lead
  to an error.
- Sanitize State Script filenames - paths based on them must not point outside of State Script directory
([MEN-9057](https://northerntech.atlassian.net/browse/MEN-9057)) ([5183bb5](https://github.com/mendersoftware/mender/commit/5183bb54f04df8152911a76f67389871440c9550))  by @michalkopczan




- Sanitize artifact's payload filenames - they must not point outside work directory when extracted
([MEN-9056](https://northerntech.atlassian.net/browse/MEN-9056)) ([f0f3fc8](https://github.com/mendersoftware/mender/commit/f0f3fc8d2ce51d29bb8c928b000b7d38fe3b1175))  by @michalkopczan




- Sanitize header list of payloads and corresponding type-info files
([MEN-9098](https://northerntech.atlassian.net/browse/MEN-9098)) ([8ab0762](https://github.com/mendersoftware/mender/commit/8ab076204cb5421ff09209dc3274b383c3067454))  by @michalkopczan




- Improve handling of arguments in artifact-gen scripts
([MEN-9115](https://northerntech.atlassian.net/browse/MEN-9115)) ([fa7f0af](https://github.com/mendersoftware/mender/commit/fa7f0afcf461e8934fd147713fc86353a08ff356))  by @vpodzime






  Fix how single-file-artifact-gen and directory-artifact-gen parse
  arguments and pass them to mender-artifact. They need to be more
  careful to prevent injected extra arguments going through the
  script to mender-artifact.
- Strip just header compression extension instead of extensions for all files
([MEN-9146](https://northerntech.atlassian.net/browse/MEN-9146)) ([b344dc6](https://github.com/mendersoftware/mender/commit/b344dc60c75e70805dffdd0e0f18b0d598f85987))  by @michalkopczan




- Return error when artifact payload contains files not present in the manifest
([MEN-9109](https://northerntech.atlassian.net/browse/MEN-9109)) ([3367ada](https://github.com/mendersoftware/mender/commit/3367ada2399eb5e027db3191c01a1f4993268c86))  by @michalkopczan




- Use boost beast's tcp_stream object
([MEN-9104](https://northerntech.atlassian.net/browse/MEN-9104)) ([2ea7c40](https://github.com/mendersoftware/mender/commit/2ea7c40216fb42524ef980910bb15da7a2c86276))  by @danielskinstad






  Scheduled async read handlers from boost beast takes a stream
  object which we close and destroy in error handlers. The issue is that on
  cases where we call the error handler with our custom timeout, we
  destroy the stream object which some async read operations still need
  access to. By leveraging boost beast's own tcp_stream object, we can get rid
  of our custom timeout and set the timeout directly in the object which
  will allow the async error handler to do its job.
- Ensure tcp_stream object doesn't hang
 ([d8ddf6d](https://github.com/mendersoftware/mender/commit/d8ddf6da29b9c76eeb68c2711a7508bafacd1701))  by @danielskinstad




- Generate new key in mender-update if needed with embedded auth
([MEN-9132](https://northerntech.atlassian.net/browse/MEN-9132)) ([94f8dd6](https://github.com/mendersoftware/mender/commit/94f8dd6a0951563b5b8c3289aa222e083d04ebac))  by @vpodzime






  When built with `MENDER_EMBED_MENDER_AUTH`, mender-update cannot
  rely on mender-auth generating a new private key if there is no
  pre-existing one.
- Prevent segfault by correctly handling dbus restarts in mender-update and mender-auth
([MEN-9144](https://northerntech.atlassian.net/browse/MEN-9144)) ([43dd888](https://github.com/mendersoftware/mender/commit/43dd88881bb5253b0ff7f3f25ccd991b300b4675))  by @michalkopczan




- Schedule next deployment poll if current one failed early causing no handler to be called
([MEN-9144](https://northerntech.atlassian.net/browse/MEN-9144)) ([6aa4c77](https://github.com/mendersoftware/mender/commit/6aa4c776107ae5b038ced51ecdeee32a8f6b9ee5))  by @michalkopczan




- Add Host header to proxy HTTP CONNECT request
([MEN-9262](https://northerntech.atlassian.net/browse/MEN-9262)) ([23e43e7](https://github.com/mendersoftware/mender/commit/23e43e700dcc687ac354771b3ab6684e41927ac8))  by @LudvigAnderson





- Make JSONL parsing to deployment log more robust
([MEN-9128](https://northerntech.atlassian.net/browse/MEN-9128)) ([39f4a3d](https://github.com/mendersoftware/mender/commit/39f4a3d66457a71541acc75496ee602f14d1846c))  by @vpodzime






- Correctly handle HTTP 429 responses that contain a body
([MEN-9342](https://northerntech.atlassian.net/browse/MEN-9342)) ([555d792](https://github.com/mendersoftware/mender/commit/555d7921ab930d5611249e25c81f453644454ca2))  by @michalkopczan









#### Features


- Add User-Agent header to HTTP requests
([MEN-1979](https://northerntech.atlassian.net/browse/MEN-1979)) ([64b0a6a](https://github.com/mendersoftware/mender/commit/64b0a6ab091daa720d074edb9b155e2e0e0cbb88))  by @jo-lund





- Add DeviceTier configuration option
([MEN-8650](https://northerntech.atlassian.net/browse/MEN-8650)) ([516541d](https://github.com/mendersoftware/mender/commit/516541d6d66dabc97a44fb7676dce8570f5cced3))  by @danielskinstad





- Enable YAML CPP by default
([MEN-8650](https://northerntech.atlassian.net/browse/MEN-8650)) ([33c2be0](https://github.com/mendersoftware/mender/commit/33c2be010379d1bff12f4c3efe36a29d21ed2768))  by @danielskinstad






  Change MENDER_USE_YAML_CPP default from OFF to ON to enable YAML
  support by default in the build. Also remove the separate build
  requirement for YAML tests since YAML CPP is now enabled by default.
- Implement system_type support for System devices
([MEN-8650](https://northerntech.atlassian.net/browse/MEN-8650)) ([8b4346b](https://github.com/mendersoftware/mender/commit/8b4346bfb9e2eb757d9f37b157c45a61a9c01305))  by @danielskinstad






  System_type is used in two specific cases:
  1) when polling for deployments
  2) when installing manifest artifacts (payload type "mender-orchestrator-manifest")
  
  Regular artifacts (e.g. rootfs updates) continue using device_type even on
  System devices, but note that these are installed through mender-orchestrator
  (through mender standalone mode) since deployment polling uses system_type.
- Send tier in authentication request
([MEN-8636](https://northerntech.atlassian.net/browse/MEN-8636)) ([e41dc3e](https://github.com/mendersoftware/mender/commit/e41dc3e405f324c0938430178db6f27e54dbbe63))  by @danielskinstad




- Error out on comma in NO_PROXY
([ME-586](https://northerntech.atlassian.net/browse/ME-586)) ([c825b8f](https://github.com/mendersoftware/mender/commit/c825b8f433cefd28de3665a48501a80592ae770d))  by @nickanderson






  Instead of warning when the NO_PROXY environment variable contains a
  comma, error out. The warning was easy to miss, and this is an invalid
  configuration that should be reported as an error.
  
  The error message is kept generic to apply to all mender clients that
  use this shared code.
- Delegate `mender_client_version` inventory key to external script
([MEN-9016](https://northerntech.atlassian.net/browse/MEN-9016)) ([9bff508](https://github.com/mendersoftware/mender/commit/9bff508f7a55040f064bda7b64213544f7438be4))  by @lluiscampos







  Mender Client is introducing a new package/recipe
  `mender-client-version-inventory-script` which will provide the Mender
  Client version not only based on `mender-update` version, but in the
  Mender Client as a whole, as documented in our official docs.
  
  Hence `mender-update` now expects the key to exist, and it will fallback
  to the old behaviour if not present.
  
  A new inventory attribute `mender_client_version_provider` is added to
  distinguish the two cases.
- Add configuration option RetryDownloadCount
([ME-589](https://northerntech.atlassian.net/browse/ME-589)) ([b0b4977](https://github.com/mendersoftware/mender/commit/b0b497776f3796e1e9b702e00d104b3be29a3763))  by @michalkopczan




- Handle HTTP 429 Too Many Requests in deployment polling
([MEN-8850](https://northerntech.atlassian.net/browse/MEN-8850)) ([dc34852](https://github.com/mendersoftware/mender/commit/dc348528daf142ba925c8258c3eb3533de4c7e6d))  by @michalkopczan





- Handle HTTP 429 Too Many Requests in inventory polling
([MEN-8850](https://northerntech.atlassian.net/browse/MEN-8850)) ([eaeb970](https://github.com/mendersoftware/mender/commit/eaeb9702e405d0bbcef2f3b4a84c94d5cdaa0e86))  by @michalkopczan





- Handle HTTP 429 Too Many Requests in deployment status and logs pushing
([MEN-8850](https://northerntech.atlassian.net/browse/MEN-8850)) ([bc70b58](https://github.com/mendersoftware/mender/commit/bc70b58d0a3be87316730eb91b5701e6ed72411e))  by @michalkopczan









#### Security


- Bump pytest in /support/modules-artifact-gen/tests
 ([e5c17ff](https://github.com/mendersoftware/mender/commit/e5c17ffa89e1d064e6bac62c40dff8311a40bb40))  by @dependabot[bot]




  Bumps [pytest](https://github.com/pytest-dev/pytest) from 8.3.3 to 8.3.4.
  - [Release notes](https://github.com/pytest-dev/pytest/releases)
  - [Changelog](https://github.com/pytest-dev/pytest/blob/main/CHANGELOG.rst)
  - [Commits](https://github.com/pytest-dev/pytest/compare/8.3.3...8.3.4)
  
  updated-dependencies:
  - dependency-name: pytest
    dependency-type: direct:production
    update-type: version-update:semver-patch
  ...
- Bump src/common/vendor/yaml-cpp from `9ce5a25` to `73ef006`
 ([1723ceb](https://github.com/mendersoftware/mender/commit/1723ceb5a095973b361f861cd3aa7a79b1cd6914))  by @dependabot[bot]




  Bumps [src/common/vendor/yaml-cpp](https://github.com/jbeder/yaml-cpp) from `9ce5a25` to `73ef006`.
  - [Release notes](https://github.com/jbeder/yaml-cpp/releases)
  - [Commits](https://github.com/jbeder/yaml-cpp/compare/9ce5a25188d83b43dd5cd633f2975be10f5d6608...73ef0060aaa1a9dc742c1d8a36fa336b35e94035)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/yaml-cpp
    dependency-type: direct:production
  ...
- Bump src/common/vendor/json from `1b9a9d1` to `a6255cc`
 ([03fb3b4](https://github.com/mendersoftware/mender/commit/03fb3b41db5f7c14a7ec6fd59414a69f991378c4))  by @dependabot[bot]




  Bumps [src/common/vendor/json](https://github.com/nlohmann/json) from `1b9a9d1` to `a6255cc`.
  - [Release notes](https://github.com/nlohmann/json/releases)
  - [Commits](https://github.com/nlohmann/json/compare/1b9a9d1f2122e73b69f5d62d0ce3ebda8cd41ff0...a6255cc418c7eb156d71c59cd4d0dc081357f907)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/json
    dependency-type: direct:production
  ...
- Remove AreFilesIdentical function
([MEN-7968](https://northerntech.atlassian.net/browse/MEN-7968)) ([db9b255](https://github.com/mendersoftware/mender/commit/db9b2558b3af15e8b130ee0b24cb62a1af199107))  by @victormlg





  AreFilesIdentical is removed because it is not used and contains a security vulnerability.
- Bump src/common/vendor/yaml-cpp from `73ef006` to `39f7374`
 ([fd4f249](https://github.com/mendersoftware/mender/commit/fd4f249f196d72c7cd809083a8012012af5d0cb3))  by @dependabot[bot]




  Bumps [src/common/vendor/yaml-cpp](https://github.com/jbeder/yaml-cpp) from `73ef006` to `39f7374`.
  - [Release notes](https://github.com/jbeder/yaml-cpp/releases)
  - [Commits](https://github.com/jbeder/yaml-cpp/compare/73ef0060aaa1a9dc742c1d8a36fa336b35e94035...39f737443b05e4135e697cb91c2b7b18095acd53)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/yaml-cpp
    dependency-type: direct:production
  ...
- Bump src/common/vendor/tiny-process-library
 ([1e61696](https://github.com/mendersoftware/mender/commit/1e616961c0a3b225c607c4166bb913ceb085bf50))  by @dependabot[bot]




  Bumps [src/common/vendor/tiny-process-library](https://gitlab.com/eidheim/tiny-process-library) from `6166ba5` to `8bbb5a2`.
  - [Release notes](https://gitlab.com/eidheim/tiny-process-library/tags)
  - [Commits](https://gitlab.com/eidheim/tiny-process-library/compare/6166ba5dce461438cefb57e847832aca25d510d7...8bbb5a211c5c9df8ee69301da9d22fb977b27dc1)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/tiny-process-library
    dependency-type: direct:production
  ...
- Bump src/common/vendor/expected from `3f0ca7b` to `41d3e1f`
 ([15055eb](https://github.com/mendersoftware/mender/commit/15055eb29344e83dc5b20b76e0c25a524ecaef6d))  by @dependabot[bot]




  Bumps [src/common/vendor/expected](https://github.com/TartanLlama/expected) from `3f0ca7b` to `41d3e1f`.
  - [Release notes](https://github.com/TartanLlama/expected/releases)
  - [Commits](https://github.com/TartanLlama/expected/compare/3f0ca7b19253129700a073abfa6d8638d9f7c80c...41d3e1f48d682992a2230b2a715bca38b848b269)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/expected
    dependency-type: direct:production
  ...
- Bump src/common/vendor/optional-lite from `927b5f7` to `67b8c3f`
 ([e7563ff](https://github.com/mendersoftware/mender/commit/e7563ff35fb1e7251e5f80e626dff73a9589a2cb))  by @dependabot[bot]




  Bumps [src/common/vendor/optional-lite](https://github.com/martinmoene/optional-lite) from `927b5f7` to `67b8c3f`.
  - [Release notes](https://github.com/martinmoene/optional-lite/releases)
  - [Commits](https://github.com/martinmoene/optional-lite/compare/927b5f76f6f524552d51a1af185b70e30be5d1fa...67b8c3fe851dbaa3430b540815fa73ee4fa7c5ad)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/optional-lite
    dependency-type: direct:production
  ...
- Bump src/common/vendor/json from `a6255cc` to `606b634`
 ([b301f01](https://github.com/mendersoftware/mender/commit/b301f01111b5c2d936d46c133cb2722951d633a1))  by @dependabot[bot]






  Bumps [src/common/vendor/json](https://github.com/nlohmann/json) from `a6255cc` to `606b634`.
  - [Release notes](https://github.com/nlohmann/json/releases)
  - [Commits](https://github.com/nlohmann/json/compare/a6255cc418c7eb156d71c59cd4d0dc081357f907...606b6347edf0758c531abb6c36743e09a4c48a84)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/json
    dependency-type: direct:production
  ...
- Bump ubuntu from 22.04 to 24.04 in /tests
 ([a73e57a](https://github.com/mendersoftware/mender/commit/a73e57a140ab8beab3035864ff00ebf2833c1525))  by @dependabot[bot]





  Bumps ubuntu from 22.04 to 24.04.
  
  updated-dependencies:
  - dependency-name: ubuntu
    dependency-type: direct:production
  ...
- Bump src/common/vendor/json from `606b634` to `8215dba`
 ([c2f3f01](https://github.com/mendersoftware/mender/commit/c2f3f01ef6e343f50f6394fdd5b67edfc7ec4a18))  by @dependabot[bot]




  Bumps [src/common/vendor/json](https://github.com/nlohmann/json) from `606b634` to `8215dba`.
  - [Release notes](https://github.com/nlohmann/json/releases)
  - [Commits](https://github.com/nlohmann/json/compare/606b6347edf0758c531abb6c36743e09a4c48a84...8215dbafbdab7c166fad02db86d4ea2a82f851c7)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/json
    dependency-type: direct:production
  ...
- Bump src/common/vendor/json from `8215dba` to `f3dc468`
 ([afe32ad](https://github.com/mendersoftware/mender/commit/afe32adb53f4b22cd74be99fd6e70fceb05ea3f6))  by @dependabot[bot]




  Bumps [src/common/vendor/json](https://github.com/nlohmann/json) from `8215dba` to `f3dc468`.
  - [Release notes](https://github.com/nlohmann/json/releases)
  - [Commits](https://github.com/nlohmann/json/compare/8215dbafbdab7c166fad02db86d4ea2a82f851c7...f3dc4684b40a124cabc8554967c2cd8db54f15dd)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/json
    dependency-type: direct:production
  ...
- Bump src/common/vendor/json from `f3dc468` to `3a57039`
 ([30e19ce](https://github.com/mendersoftware/mender/commit/30e19ce5c69a5a337ec512873e0089b6b5acb6b9))  by @dependabot[bot]




  Bumps [src/common/vendor/json](https://github.com/nlohmann/json) from `f3dc468` to `3a57039`.
  - [Release notes](https://github.com/nlohmann/json/releases)
  - [Commits](https://github.com/nlohmann/json/compare/f3dc4684b40a124cabc8554967c2cd8db54f15dd...3a5703931ad70852b668a46cac34354d1b264442)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/json
    dependency-type: direct:production
  ...
- Bump src/common/vendor/optional-lite from `67b8c3f` to `44ae889`
 ([be16284](https://github.com/mendersoftware/mender/commit/be162841964674c6ecd931af7001ce0ea73873b7))  by @dependabot[bot]




  Bumps [src/common/vendor/optional-lite](https://github.com/martinmoene/optional-lite) from `67b8c3f` to `44ae889`.
  - [Release notes](https://github.com/martinmoene/optional-lite/releases)
  - [Commits](https://github.com/martinmoene/optional-lite/compare/67b8c3fe851dbaa3430b540815fa73ee4fa7c5ad...44ae889d969117c05d84c96f34e20f9e1b5a1511)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/optional-lite
    dependency-type: direct:production
  ...
- Bump src/common/vendor/yaml-cpp from `39f7374` to `28f93bd`
 ([31b551f](https://github.com/mendersoftware/mender/commit/31b551f6fb8810e4fd20c82defa1bf81abf9ba96))  by @dependabot[bot]




  Bumps [src/common/vendor/yaml-cpp](https://github.com/jbeder/yaml-cpp) from `39f7374` to `28f93bd`.
  - [Release notes](https://github.com/jbeder/yaml-cpp/releases)
  - [Commits](https://github.com/jbeder/yaml-cpp/compare/39f737443b05e4135e697cb91c2b7b18095acd53...28f93bdec6387d42332220afa9558060c8016795)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/yaml-cpp
    dependency-type: direct:production
  ...
- Bump src/common/vendor/json from `3a57039` to `dff2b47`
 ([c02244a](https://github.com/mendersoftware/mender/commit/c02244a0110e9745f8be2be96ba003fe5ceeca00))  by @dependabot[bot]




  Bumps [src/common/vendor/json](https://github.com/nlohmann/json) from `3a57039` to `dff2b47`.
  - [Release notes](https://github.com/nlohmann/json/releases)
  - [Commits](https://github.com/nlohmann/json/compare/3a5703931ad70852b668a46cac34354d1b264442...dff2b4756cedca462721dc9666a2fbc05d47b486)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/json
    dependency-version: dff2b4756cedca462721dc9666a2fbc05d47b486
    dependency-type: direct:production
  ...
- Bump src/common/vendor/yaml-cpp from `28f93bd` to `2f86d13`
 ([855692a](https://github.com/mendersoftware/mender/commit/855692aba72a7253216d2cb0490d4499888f845d))  by @dependabot[bot]






  Bumps [src/common/vendor/yaml-cpp](https://github.com/jbeder/yaml-cpp) from `28f93bd` to `2f86d13`.
  - [Release notes](https://github.com/jbeder/yaml-cpp/releases)
  - [Commits](https://github.com/jbeder/yaml-cpp/compare/28f93bdec6387d42332220afa9558060c8016795...2f86d13775d119edbb69af52e5f566fd65c6953b)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/yaml-cpp
    dependency-version: 2f86d13775d119edbb69af52e5f566fd65c6953b
    dependency-type: direct:production
  ...
- Bump src/common/vendor/json from `230bfd1` to `82f4f70`
 ([65afecb](https://github.com/mendersoftware/mender/commit/65afecbdcc17a8f5afe79a71ba6f058a0caa05f6))  by @dependabot[bot]




  Bumps [src/common/vendor/json](https://github.com/nlohmann/json) from `230bfd1` to `82f4f70`.
  - [Release notes](https://github.com/nlohmann/json/releases)
  - [Commits](https://github.com/nlohmann/json/compare/230bfd15a2bb7f01ebb3fcd3cf898b697ef43c48...82f4f706693f689c6b304313f57666b92024070e)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/json
    dependency-version: 82f4f706693f689c6b304313f57666b92024070e
    dependency-type: direct:production
  ...
- Bump src/common/vendor/json from `568b708` to `b451735`
 ([2c99e64](https://github.com/mendersoftware/mender/commit/2c99e64d44c54ea5984e2545c1a044484a921aab))  by @dependabot[bot]




  Bumps [src/common/vendor/json](https://github.com/nlohmann/json) from `568b708` to `b451735`.
  - [Release notes](https://github.com/nlohmann/json/releases)
  - [Commits](https://github.com/nlohmann/json/compare/568b708fd46deeb23a959381393a7564f1586588...b451735fe7bb3283336f934b3f6cd3f484f73649)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/json
    dependency-version: b451735fe7bb3283336f934b3f6cd3f484f73649
    dependency-type: direct:production
  ...
- Bump src/common/vendor/json from `b451735` to `d33ecd3`
 ([26b7e9b](https://github.com/mendersoftware/mender/commit/26b7e9b95cb0e97922cc24de3cb342a616dcb058))  by @dependabot[bot]




  Bumps [src/common/vendor/json](https://github.com/nlohmann/json) from `b451735` to `d33ecd3`.
  - [Release notes](https://github.com/nlohmann/json/releases)
  - [Commits](https://github.com/nlohmann/json/compare/b451735fe7bb3283336f934b3f6cd3f484f73649...d33ecd3f3bd11e30aa8bbabb00e0a9cd3f2456d8)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/json
    dependency-version: d33ecd3f3bd11e30aa8bbabb00e0a9cd3f2456d8
    dependency-type: direct:production
  ...
- Bump libboost_log to 1.83.0
 ([ddbfda1](https://github.com/mendersoftware/mender/commit/ddbfda157471dbdeaec8af85ba43acdb79dbe173))  by @danielskinstad




  The following errors are present in mendersoftware/mender-client-docker:mender-master
  
  ```
  mender-auth: error while loading shared libraries: libboost_log.so.1.83.0: cannot open shared object file: No such file or directory
  mender-update: error while loading shared libraries: libboost_log.so.1.83.0: cannot open shared object file: No such file or directory
  ```
- Bump src/common/vendor/json from `d33ecd3` to `c637a8b`
 ([840562a](https://github.com/mendersoftware/mender/commit/840562ab2e51f7918a86f1070a29f54b2c767a72))  by @dependabot[bot]




  Bumps [src/common/vendor/json](https://github.com/nlohmann/json) from `d33ecd3` to `c637a8b`.
  - [Release notes](https://github.com/nlohmann/json/releases)
  - [Commits](https://github.com/nlohmann/json/compare/d33ecd3f3bd11e30aa8bbabb00e0a9cd3f2456d8...c637a8b453dfc772f7819eb373af1c683c522635)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/json
    dependency-version: c637a8b453dfc772f7819eb373af1c683c522635
    dependency-type: direct:production
  ...
- Bump src/common/vendor/expected from `41d3e1f` to `ea916f3`
 ([30dca11](https://github.com/mendersoftware/mender/commit/30dca11042b4ba1bee92631a8ae25115de6fc24e))  by @danielskinstad





  Bumps [src/common/vendor/expected](https://github.com/TartanLlama/expected) from `41d3e1f` to `ea916f3`.
  - [Release notes](https://github.com/TartanLlama/expected/releases)
  - [Commits](https://github.com/TartanLlama/expected/compare/41d3e1f48d682992a2230b2a715bca38b848b269...ea916f39627f02f192b5ec532210ab184e266e3e)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/expected
    dependency-version: ea916f39627f02f192b5ec532210ab184e266e3e
    dependency-type: direct:production
  ...
  
  After bumping expected we started seeing failures in unit tests that we
  were ignoring returned value types of `ExpectedSize`.
  Check return value of function calls that return ExpectedSize in unit test.
- Bump src/common/vendor/json from `c637a8b` to `4bc4e37`
 ([c58764c](https://github.com/mendersoftware/mender/commit/c58764cc43e7d0d84b5334ee033140ae6ae5eb57))  by @dependabot[bot]




  Bumps [src/common/vendor/json](https://github.com/nlohmann/json) from `c637a8b` to `4bc4e37`.
  - [Release notes](https://github.com/nlohmann/json/releases)
  - [Commits](https://github.com/nlohmann/json/compare/c637a8b453dfc772f7819eb373af1c683c522635...4bc4e37f4f56f88b3a80abb7a6508b19a244e803)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/json
    dependency-version: 4bc4e37f4f56f88b3a80abb7a6508b19a244e803
    dependency-type: direct:production
  ...
- Bump src/common/vendor/expected from `ea916f3` to `1770e35`
 ([34e3d61](https://github.com/mendersoftware/mender/commit/34e3d61c78b54605c39f93ea6182aecbacb2d885))  by @dependabot[bot]




  Bumps [src/common/vendor/expected](https://github.com/TartanLlama/expected) from `ea916f3` to `1770e35`.
  - [Release notes](https://github.com/TartanLlama/expected/releases)
  - [Commits](https://github.com/TartanLlama/expected/compare/ea916f39627f02f192b5ec532210ab184e266e3e...1770e3559f2f6ea4a5fb4f577ad22aeb30fbd8e4)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/expected
    dependency-version: 1770e3559f2f6ea4a5fb4f577ad22aeb30fbd8e4
    dependency-type: direct:production
  ...
- Bump src/common/vendor/json from `87a3e4d` to `3ed64e5`
 ([b2169d4](https://github.com/mendersoftware/mender/commit/b2169d407b1e54bef70087bce2c8c0a0cbce6490))  by @dependabot[bot]




  Bumps [src/common/vendor/json](https://github.com/nlohmann/json) from `87a3e4d` to `3ed64e5`.
  - [Release notes](https://github.com/nlohmann/json/releases)
  - [Commits](https://github.com/nlohmann/json/compare/87a3e4de9903be9acdc66418c29182c6f979d707...3ed64e502a6371311af3c2f309e6525b2f5f6f18)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/json
    dependency-version: 3ed64e502a6371311af3c2f309e6525b2f5f6f18
    dependency-type: direct:production
  ...
- Bump src/common/vendor/optional-lite from `44ae889` to `5411501`
 ([283dc84](https://github.com/mendersoftware/mender/commit/283dc84008ba874f661cf6620c917658b1bee223))  by @dependabot[bot]




  Bumps [src/common/vendor/optional-lite](https://github.com/martinmoene/optional-lite) from `44ae889` to `5411501`.
  - [Release notes](https://github.com/martinmoene/optional-lite/releases)
  - [Commits](https://github.com/martinmoene/optional-lite/compare/44ae889d969117c05d84c96f34e20f9e1b5a1511...54115013989efd1bb5f4a5668af021a1791b5e1f)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/optional-lite
    dependency-version: 54115013989efd1bb5f4a5668af021a1791b5e1f
    dependency-type: direct:production
  ...
- Bump src/common/vendor/yaml-cpp from `2f86d13` to `65c1c27`
 ([6b74266](https://github.com/mendersoftware/mender/commit/6b74266c363ede2a6b303cc42ca87e4062e0a46e))  by @dependabot[bot]




  Bumps [src/common/vendor/yaml-cpp](https://github.com/jbeder/yaml-cpp) from `2f86d13` to `65c1c27`.
  - [Release notes](https://github.com/jbeder/yaml-cpp/releases)
  - [Commits](https://github.com/jbeder/yaml-cpp/compare/2f86d13775d119edbb69af52e5f566fd65c6953b...65c1c270dbe7eec37b2df2531d7497c4eea79aee)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/yaml-cpp
    dependency-version: 65c1c270dbe7eec37b2df2531d7497c4eea79aee
    dependency-type: direct:production
  ...
- Bump src/common/vendor/json from `3ed64e5` to `8deac49`
 ([2c1bf75](https://github.com/mendersoftware/mender/commit/2c1bf7567730dd0f06ee4d1a79550b57b6cfe5a8))  by @dependabot[bot]




  Bumps [src/common/vendor/json](https://github.com/nlohmann/json) from `3ed64e5` to `8deac49`.
  - [Release notes](https://github.com/nlohmann/json/releases)
  - [Commits](https://github.com/nlohmann/json/compare/3ed64e502a6371311af3c2f309e6525b2f5f6f18...8deac49f5039391749606259045acda205fe39ef)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/json
    dependency-version: 8deac49f5039391749606259045acda205fe39ef
    dependency-type: direct:production
  ...
- Bump src/common/vendor/optional-lite from `5411501` to `5f924cb`
 ([97cd21f](https://github.com/mendersoftware/mender/commit/97cd21f4a62b1cb3c5f70ada0e783de6119d556f))  by @dependabot[bot]




  Bumps [src/common/vendor/optional-lite](https://github.com/martinmoene/optional-lite) from `5411501` to `5f924cb`.
  - [Release notes](https://github.com/martinmoene/optional-lite/releases)
  - [Commits](https://github.com/martinmoene/optional-lite/compare/54115013989efd1bb5f4a5668af021a1791b5e1f...5f924cbfc130484d4820bb105d6ad1a42df930e0)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/optional-lite
    dependency-version: 5f924cbfc130484d4820bb105d6ad1a42df930e0
    dependency-type: direct:production
  ...
- Bump src/common/vendor/json from `8deac49` to `a0e9fb1`
 ([e2e47a2](https://github.com/mendersoftware/mender/commit/e2e47a21b53276136a0854324c62ea0506337851))  by @dependabot[bot]




  Bumps [src/common/vendor/json](https://github.com/nlohmann/json) from `8deac49` to `a0e9fb1`.
  - [Release notes](https://github.com/nlohmann/json/releases)
  - [Commits](https://github.com/nlohmann/json/compare/8deac49f5039391749606259045acda205fe39ef...a0e9fb1e638cfbb5b8b556b7c51eaa81977bad48)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/json
    dependency-version: a0e9fb1e638cfbb5b8b556b7c51eaa81977bad48
    dependency-type: direct:production
  ...
- Bump src/common/vendor/json from `02ac0d6` to `14374af`
 ([f7f7a6f](https://github.com/mendersoftware/mender/commit/f7f7a6f6f6739222c99350eafa9ef3c31051a9a2))  by @danielskinstad





  Bumps [src/common/vendor/json](https://github.com/nlohmann/json) from `02ac0d6` to `14374af`.
  - [Release notes](https://github.com/nlohmann/json/releases)
  - [Commits](https://github.com/nlohmann/json/compare/02ac0d6525f2e046f136ca69b5105b4e4f315b2f...14374af9e5727aa824676f2a2f731fdf054c4c97)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/json
    dependency-version: 14374af9e5727aa824676f2a2f731fdf054c4c97
    dependency-type: direct:production
  ...
  
  Modified license checksums
- Bump src/common/vendor/yaml-cpp from `a83cd31` to `c7aa78d`
 ([55f0e30](https://github.com/mendersoftware/mender/commit/55f0e30aacf3aa998af837e6bba2513ac631a52b))  by @dependabot[bot]




  Bumps [src/common/vendor/yaml-cpp](https://github.com/jbeder/yaml-cpp) from `a83cd31` to `c7aa78d`.
  - [Release notes](https://github.com/jbeder/yaml-cpp/releases)
  - [Commits](https://github.com/jbeder/yaml-cpp/compare/a83cd31548b19d50f3f983b069dceb4f4d50756d...c7aa78d294bbe499c1ebc0abfa1e103490c8525f)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/yaml-cpp
    dependency-version: c7aa78d294bbe499c1ebc0abfa1e103490c8525f
    dependency-type: direct:production
  ...
- Bump src/common/vendor/json from `8f75700` to `553c314`
 ([145c2f0](https://github.com/mendersoftware/mender/commit/145c2f030f37227f10f6b98c96a9ce0af008f141))  by @dependabot[bot]




  Bumps [src/common/vendor/json](https://github.com/nlohmann/json) from `8f75700` to `553c314`.
  - [Release notes](https://github.com/nlohmann/json/releases)
  - [Commits](https://github.com/nlohmann/json/compare/8f7570014107c5040103c5c4f9a55250be9add0c...553c314fb873451565e963385d80c4748bc43576)
  
  updated-dependencies:
  - dependency-name: src/common/vendor/json
    dependency-version: 553c314fb873451565e963385d80c4748bc43576
    dependency-type: direct:production
  ...




#### Build


- Install `mender-artifact` from final tag on the test container
 ([d9825a9](https://github.com/mendersoftware/mender/commit/d9825a979f9777de9e58e5b15b353c0e9a70d997))  by @lluiscampos




  So that we stop using the experimental APT repos, which we should not
  rely on.




#### Refac


- Added warning when using basic auth
([MEN-7983](https://northerntech.atlassian.net/browse/MEN-7983)) ([bc10461](https://github.com/mendersoftware/mender/commit/bc10461c17cc736975a5f2e7f2d2f4eec6565501))  by @victormlg



- Refactor deployment http handlers to make them testable and prepare for HTTP 429 handling
([MEN-8850](https://northerntech.atlassian.net/browse/MEN-8850)) ([8afd047](https://github.com/mendersoftware/mender/commit/8afd0477da99fd16d79d5529196a8cc3ad441bed))  by @michalkopczan



- Refactor inventory http handlers to make them testable and prepare for HTTP 429 handling
([MEN-8850](https://northerntech.atlassian.net/browse/MEN-8850)) ([51eddb9](https://github.com/mendersoftware/mender/commit/51eddb93939fd2e06ac28c4f116684b5bd6d654d))  by @michalkopczan



- Refactor PushLogs and PushStatus http handlers to make them testable and prepare for HTTP 429 handling
([MEN-8850](https://northerntech.atlassian.net/browse/MEN-8850)) ([87124c6](https://github.com/mendersoftware/mender/commit/87124c60babb94779986187761e454cca332246a))  by @michalkopczan

## mender-connect master (2026-02-17)

### master - 2026-02-17


#### Bug fixes


- Preserve group assignments
([ME-530](https://northerntech.atlassian.net/browse/ME-530)) ([f5bea59](https://github.com/mendersoftware/mender-connect/commit/f5bea591ec7a53700122692764689df4a42ca205))  by @danielskinstad




- Make StopShell function re-entrant by protecting stop channel
([MEN-9029](https://northerntech.atlassian.net/browse/MEN-9029)) ([b3fb7ed](https://github.com/mendersoftware/mender-connect/commit/b3fb7edabae4909cbc361bb2ecc34d8d3b86d770))  by @alfrunes









#### Features


- Lower backoff intervals
([ME-546](https://northerntech.atlassian.net/browse/ME-546)) ([8ce8f78](https://github.com/mendersoftware/mender-connect/commit/8ce8f78bbf8747ec0cfdfbc0fdcb851ea9b89f75))  by @danielskinstad






  The previous backoff had a starting interval at 1
  minute and a max backoff at 60 minutes. When it reached 60 minutes it
  would linearly increase to 120 minutes minutes where it would keep
  retrying.
  
  The backoff will now start at 1 second and exponentially increase after
  3 retries until it reaches 30 minutes where it will keep retrying.
  For each interval a jitter between 0 and 5 seconds will be added.
- Enable 10 minute idle timeout by default
([MEN-8260](https://northerntech.atlassian.net/browse/MEN-8260)) ([15df4b2](https://github.com/mendersoftware/mender-connect/commit/15df4b2fa9b4806c76f4356583b4bcb084c0ffd2))  by @danielskinstad






  Introduce a default value of 10 minutes to `ExpireAfterIdle` and set
  `StopExpired` to true by default. This is done in order to prioritize
  auto healing of mender-connect over the ability to have a theoretically
  endless session.




#### Security


- Bump github.com/stretchr/testify from 1.10.0 to 1.11.1
 ([3771554](https://github.com/mendersoftware/mender-connect/commit/37715542c240bf112bc634a287e4c4f7646cadaf))  by @dependabot[bot]




  Bumps [github.com/stretchr/testify](https://github.com/stretchr/testify) from 1.10.0 to 1.11.1.
  - [Release notes](https://github.com/stretchr/testify/releases)
  - [Commits](https://github.com/stretchr/testify/compare/v1.10.0...v1.11.1)
  
  updated-dependencies:
  - dependency-name: github.com/stretchr/testify
    dependency-version: 1.11.1
    dependency-type: direct:production
    update-type: version-update:semver-minor
  ...
- Bump github.com/sirupsen/logrus from 1.9.3 to 1.9.4
 ([97fd3f4](https://github.com/mendersoftware/mender-connect/commit/97fd3f42a67baf7064462bd89a8707e895151783))  by @dependabot[bot]




  Bumps [github.com/sirupsen/logrus](https://github.com/sirupsen/logrus) from 1.9.3 to 1.9.4.
  - [Release notes](https://github.com/sirupsen/logrus/releases)
  - [Changelog](https://github.com/sirupsen/logrus/blob/master/CHANGELOG.md)
  - [Commits](https://github.com/sirupsen/logrus/compare/v1.9.3...v1.9.4)
  
  updated-dependencies:
  - dependency-name: github.com/sirupsen/logrus
    dependency-version: 1.9.4
    dependency-type: direct:production
    update-type: version-update:semver-patch
  ...




#### Refac


- Migrate from gorilla/websocket to coder/websocket
 ([2e8105e](https://github.com/mendersoftware/mender-connect/commit/2e8105e9f3ba8cef3e4161e362d83a38f9997634))  by @alfrunes

## monitor-client master (2026-02-23)

### master - 2026-02-23


#### Bug fixes


- Missing service_ prefix so an incorrect argument is passed.
([MEN-8068](https://northerntech.atlassian.net/browse/MEN-8068)) ([5a6b181](https://github.com/mendersoftware/monitor-client/commit/5a6b1814333bb676c32c62bb2d4150445fcf5435))  by @MuchoLucho







  This prints out an empty string for flapping rate/count in the logs. The first argument should have a prefix e.g `service_`.
- Incorrect value for STATUS_BY_LOG_NAME
([ME-474](https://northerntech.atlassian.net/browse/ME-474)) ([fe2f43b](https://github.com/mendersoftware/monitor-client/commit/fe2f43b26f40b5a9634ea83e8483269f1eb8ff2d))  by @nickanderson





- Redirect USB disconnect log to journal
([MEN-8348](https://northerntech.atlassian.net/browse/MEN-8348)) ([a515d03](https://github.com/mendersoftware/monitor-client/commit/a515d03fb9bdd42fb45dfe14a6a34081942f40cf))  by @elkoniu






  On Debian Bookworm log file /var/log/kern.log used by USB disconnect
  script is not existing. This commit changes script behavior to use
  journal instead.
- Avoid setting description to an empty string
([MEN-8710](https://northerntech.atlassian.net/browse/MEN-8710)) ([165b9a3](https://github.com/mendersoftware/monitor-client/commit/165b9a37735f4750d40cfaddec1eb5139661335e))  by @nickanderson






  This change fixes a case where the log description is set to an empty string. It
  also aligns the variable with alert_description and description elsewhere in the
  script.
  
  Additionally prevented other cases of undesirable empty variables
  
  - status could have been set to an empty string as LOG_ALERT_STATUS is not
    obviously defined
  
  - subject_type would have been set to an empty string as indicated by the if
    condition
- Add warning message about possible log flood
([MEN-7216](https://northerntech.atlassian.net/browse/MEN-7216)) ([bb875d8](https://github.com/mendersoftware/monitor-client/commit/bb875d86221c3d6cbcaf5cd5e5c68d8007272879))  by @elkoniu






  By default dbus monitor uses two settings to filter out messages:
  * DBUS_PATTERN
  * DBUS_WATCH_EXPRESSION
  
  When none of them are set result is collecting all possible dbus
  messages. This changes adds a warning message for the user about possible log flood when none of the filters is set.
- Log_usb_disconnect not working with getting started - adjust regex
([MEN-8704](https://northerntech.atlassian.net/browse/MEN-8704)) ([1491e9f](https://github.com/mendersoftware/monitor-client/commit/1491e9fe8a11a408cedbbe4efae75c38ed6df15c))  by @michalkopczan






  This is a first in a series of commits fixing the usb log monitoring.
  This commit changes the regex for usb disconnect to a correct one. This makes
  the usb monitoring work in general, but it does not fix an issue where,
  if a monitoring service is enabled after the monitor daemon is already running,
  the new service won't work until monitor damoen is restarted.
- Log_usb_disconnect not working with getting started
([MEN-8704](https://northerntech.atlassian.net/browse/MEN-8704)) ([f4eb940](https://github.com/mendersoftware/monitor-client/commit/f4eb940bea1d65d8565e70aca962584013fdd1df))  by @michalkopczan






  USB monitoring was not working with getting started because of 1) the log collecting commands
  were started only once at mender-monitor startup. If "mender-monitorctl enable" was called
  for a log collector that uses a command (as opposed to log file) while mender-monitor was
  running already, the command was not started, and 2) log regex was wrong for use with journalctl.
  
  This commit introduces following changes:
  - starting log collecting commands in a loop
  - monitoring of log collecting commands statuses, and restarting them if needed
  - (*)monitoring of pattern_expiration_worker status from each log_watch_cmd, exiting if pattern_expiration_worker is no longer alive
  - (*)monitoring of log_watch_cmd process status from pattern_expiration_worker, exiting if the log_watch_cmd is no longer alive
  
  * - all exited commands are restarted by the log collecting commands monitoring code
- Mender-monitor occasionally produces malformed entries for false positives
([MEN-8710](https://northerntech.atlassian.net/browse/MEN-8710)) ([209f72e](https://github.com/mendersoftware/monitor-client/commit/209f72e08a8611bea96cc54cc4cc9b9afa78dc7e))  by @michalkopczan







  mender-monitor produced a false positive log alert, with only the log pattern visible in
  the alert, instead of "Log file contains (log pattern)". This was caused by incomplete
  reads causing the log expiration monitoring function to treat the incomplete read not as a
  request from the monitoring function to check if a given log pattern is expired, but as a
  new log pattern to be monitored for expiration.
  When the "new" log pattern expired, an OK alert was sent with the malformed message.
  
  Incomplete reads were almost exclusively visible at system startup - probably due to high system
  load. They could also become visible when multiple alerts were being sent in a short time.
  
  Fix introduces incomplete reads handling.
- Added silent flag to curl in alert-lib.sh
 ([34d6af6](https://github.com/mendersoftware/monitor-client/commit/34d6af68296b8cecd81c02e6bb7d08e870ffec0f))  by @MuchoLucho






  There was a `curl` command lacking of `--silent` flag.
  It was affecting the journal with messages like:
  
  ```text
  Jun 24 20:59:27 dummy-device mender-monitord[2921]: 2025-06-24 20:59:27 [INFO] [daemon.sh:xxx:104] non-empty alert store found
  Jun 24 20:59:27 dummy-device mender-monitord[46928]:   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
  Jun 24 20:59:27 dummy-device mender-monitord[46928]:                                  Dload  Upload   Total   Spent    Left  Speed
  Jun 24 20:59:27 dummy-device mender-monitord[46928]: [237B blob data]
  ```




#### Features


- Add `version` argument support to mender-monitorctl
([MEN-8249](https://northerntech.atlassian.net/browse/MEN-8249)) ([76987dd](https://github.com/mendersoftware/monitor-client/commit/76987dd1254d39c64b1204d39c74f95ba8f51a17))  by @elkoniu






  This PR adds new `version` argument which can be called standalone
  to obtain ctl tool version.

## mender-flash master (2026-02-23)

### master - 2026-02-23


#### Bug fixes


- Support flashing more than 4 GiB in 32 bit builds
 ([0031e01](https://github.com/mendersoftware/mender-flash/commit/0031e0184c0ebefc033e8a5bb3a503ea6bf8cae5))  by @vpodzime






  `_FILE_OFFSET_BITS` needs to be set to 64 so that I/O
  functions/syscalls working with files and devices use 64 bits to
  represent sizes. The `off_t` type needs to be used instead of
  `size_t` in places where file/device sizes and total numbers of
  bytes are used. OTOH, `size_t` is the type used by many I/O
  functions/syscalls which has to be respected.
- Fix UBI device detection
([MEN-7156](https://northerntech.atlassian.net/browse/MEN-7156)) ([8100797](https://github.com/mendersoftware/mender-flash/commit/8100797f2caf6221b9cdea0b8596cb544a97bfc2))  by @vpodzime






  Ported commit b69fa5faf6c43c5037853e2564a81d5c950f0287 to use
  a check based on the `/sys/class/ubi` tree rather than major
  device number which is not guaranteed to be stable.
  
  Also, UBI volumes have character device nodes not block device nodes.
- Do `fsync(out_fd)` before `close(out_fd)`
([MEN-7862](https://northerntech.atlassian.net/browse/MEN-7862)) ([5099e88](https://github.com/mendersoftware/mender-flash/commit/5099e88a1c7a80ff1dcd6cd924ddc4bda87ace7c))  by @vpodzime






  `close()` doesn't guarantee a sync:
  
  > A successful close does not guarantee that the data has been
  > successfully saved to disk, as the kernel uses the buffer cache
  > to defer writes.
- Use shoveling for writing to UBI devices
([MEN-8604](https://northerntech.atlassian.net/browse/MEN-8604)) ([8b92ab6](https://github.com/mendersoftware/mender-flash/commit/8b92ab6eff3d5685befa2ce0eb249f021660f14d))  by @vpodzime






  The nicer and fancier syscalls don't support UBI devices.
  
  OTOH, we do support syncing when using them so let's fix the
  comment in two ways with a single change!
- Fix handling of the '-f' short option
 ([280ea2a](https://github.com/mendersoftware/mender-flash/commit/280ea2a994ed2f086b1b8407fc11de6bdbb35c57))  by @vpodzime






  `getopt_long()` is called in two places in the code, so all
  options need to be present in both of the calls. Let's avoid this
  in the future by defining a macro and using it in both places.




#### Features


- A minimal and portable version of mender-flash
 ([bd4acbe](https://github.com/mendersoftware/mender-flash/commit/bd4acbe0b0c21014e5b2435afd50a1de7479f171))  by @vpodzime






  Written in C, much smaller and very straightforward, but doing
  the same thing.
  
  Also much faster to compile/build and with no dependencies.
- Use in-kernel copying on Linux
 ([8aa1e36](https://github.com/mendersoftware/mender-flash/commit/8aa1e36d87a578e275d849529ac2efb91b885274))  by @vpodzime






  Linux provide syscalls to copy data between two file descriptors
  directly in kernel without using user-space buffers. There's no
  reason to not use them to save some CPU cycles and potentially do
  the I/O in a more optimized way.
- Add an option to specify the fsync interval
 ([450fce0](https://github.com/mendersoftware/mender-flash/commit/450fce01d974cca80d5dd89b108349b587299733))  by @vpodzime






  And use BLOCK_SIZE as the default.
- Optimize writes by default and let the user force them
 ([1cf25a5](https://github.com/mendersoftware/mender-flash/commit/1cf25a506a16e32000e8cd795ac4a7486b3a49ed))  by @vpodzime






  Potentially reducing wear of flash memory used as the target
  device and potentially speeding things up if the target device
  has much faster reads than writes.
  
  OTOH, often it's just much faster to write all the data.
- Enable use of sendfile/splice with fsync_interval
 ([65723e1](https://github.com/mendersoftware/mender-flash/commit/65723e1077a78025ee713fbc8522c550b0e7ee86))  by @vpodzime






  We can simply as kernel to handle at most fsync_interval of bytes
  at once. Still fewer syscalls and no unnecessary user-space
  buffers needed.

## mender-configure-module master (2026-02-23)

### master - 2026-02-23


#### Bug fixes


- Make systemd installation systemd_unitdir aware
 ([758d25f](https://github.com/mendersoftware/mender-configure-module/commit/758d25f2b662c0ba2f20dbc6552c0daa6af1cc5f))  by @TheYoctoJester





- Exit with returncode 0 if no jwt token is obtained over dbus
([MEN-8591](https://northerntech.atlassian.net/browse/MEN-8591)) ([7bcd1b7](https://github.com/mendersoftware/mender-configure-module/commit/7bcd1b7f33a4c9dc8cf3970e2da27fe38bf32277))  by @danielskinstad






  `mender-inventory-mender-configure` produces an error when failing to
  fetch the JWT token over DBus. If we exit with 1 mender-update will log:
  ```
  raspberrypi mender-update[1070]: An authentication token could not be obtained over DBus.
  mender-update[1029]: record_id=3 severity=error time="2025-Jun-12 21:53:25.802076" name="Global" msg="'/usr/share/mender/inventory/mender-inventory-mender-configure' failed: Process...
  ```
  Now it will log:
  `raspberrypi mender-update[1070]: mender-inventory-mender-configure: An authentication token could not be obtained over DBus.`
- Fixed outdated LED-path for raspberrypi
([MEN-9002](https://northerntech.atlassian.net/browse/MEN-9002)) ([40a442c](https://github.com/mendersoftware/mender-configure-module/commit/40a442c660070ed9a0393410b4168f942e8c8782))  by @rewanrashid-boop




- Fixed on/off arguments in LED demo
([MEN-9375](https://northerntech.atlassian.net/browse/MEN-9375)) ([914a46a](https://github.com/mendersoftware/mender-configure-module/commit/914a46a62a3ec44c93fb0c438b22191f762e368a))  by @danielskinstad








#### Features


- Mender-configure requests JWT token when needed
([MEN-7732](https://northerntech.atlassian.net/browse/MEN-7732)) ([00c6064](https://github.com/mendersoftware/mender-configure-module/commit/00c60647636abe169879ac843fb204c1fa883fda))  by @victormlg






  If the token is invalid or inexistant, mender-configure will fetch a new Jwt Token.
  Mender configure will listen to the dbus-monitor for a Jwt token state change. If token is received, it will immediately get the new token and continue the execution of the program. If the token is not received within 5 seconds, the program times out.




#### Security


- Bump tests/unit/shunit2 from `47be8b2` to `3334e53`
 ([c3d9c66](https://github.com/mendersoftware/mender-configure-module/commit/c3d9c669875243236d19bcbe025a02e1c11f90bf))  by @dependabot[bot]




  Bumps [tests/unit/shunit2](https://github.com/kward/shunit2) from `47be8b2` to `3334e53`.
  - [Release notes](https://github.com/kward/shunit2/releases)
  - [Commits](https://github.com/kward/shunit2/compare/47be8b23a46a7897e849f1841f0fb704d34d0f6e...3334e53047ad143669870a9c223b70a81156533a)
  
  updated-dependencies:
  - dependency-name: tests/unit/shunit2
    dependency-type: direct:production
  ...
- Bump tests/integration/mender_test_containers
 ([9f61038](https://github.com/mendersoftware/mender-configure-module/commit/9f6103897189e65d823ce3a9a429524b0e7d9407))  by @dependabot[bot]




  Bumps [tests/integration/mender_test_containers](https://github.com/mendersoftware/mender-test-containers) from `222916a` to `cc27472`.
  - [Commits](https://github.com/mendersoftware/mender-test-containers/compare/222916ae5b0632521139170cc4410d1242c3751d...cc27472c35c41d9fe2614f37d54bc91ccfc2f4f6)
  
  updated-dependencies:
  - dependency-name: tests/integration/mender_test_containers
    dependency-type: direct:production
  ...
- Bump tests/integration/mender_integration
 ([df654b9](https://github.com/mendersoftware/mender-configure-module/commit/df654b971e31b4c42d7f26c734277b564ec9f892))  by @dependabot[bot]




  Bumps [tests/integration/mender_integration](https://github.com/mendersoftware/integration) from `e0ddb9f` to `ca37b76`.
  - [Commits](https://github.com/mendersoftware/integration/compare/e0ddb9f641912775e81953a24002bdc406e8338f...ca37b7694c40baf77ba3837f5a1398ceafe2ee54)
  
  updated-dependencies:
  - dependency-name: tests/integration/mender_integration
    dependency-type: direct:production
  ...
- Bump tests/unit/shunit2 from `3334e53` to `da1e19d`
 ([a81e1b3](https://github.com/mendersoftware/mender-configure-module/commit/a81e1b31e29a0da53da25d4eaee2a329d402db4a))  by @dependabot[bot]




  Bumps [tests/unit/shunit2](https://github.com/kward/shunit2) from `3334e53` to `da1e19d`.
  - [Release notes](https://github.com/kward/shunit2/releases)
  - [Commits](https://github.com/kward/shunit2/compare/3334e53047ad143669870a9c223b70a81156533a...da1e19de845a77628d9684e609cc0f8160782c68)
  
  updated-dependencies:
  - dependency-name: tests/unit/shunit2
    dependency-type: direct:production
  ...
- Bump tests/unit/shunit2 from `da1e19d` to `100ffe4`
 ([79785c5](https://github.com/mendersoftware/mender-configure-module/commit/79785c5deba85596741e912e7e8c0326d9d7ee56))  by @dependabot[bot]




  Bumps [tests/unit/shunit2](https://github.com/kward/shunit2) from `da1e19d` to `100ffe4`.
  - [Release notes](https://github.com/kward/shunit2/releases)
  - [Commits](https://github.com/kward/shunit2/compare/da1e19de845a77628d9684e609cc0f8160782c68...100ffe4dda539ebbe4ae9867132f08eeee8e80cb)
  
  updated-dependencies:
  - dependency-name: tests/unit/shunit2
    dependency-type: direct:production
  ...
- Bump tests/unit/shunit2 from `100ffe4` to `0f27c1a`
 ([63f0cdf](https://github.com/mendersoftware/mender-configure-module/commit/63f0cdf0552ececd08a5605b33cfbbc0cbc45cba))  by @dependabot[bot]




  Bumps [tests/unit/shunit2](https://github.com/kward/shunit2) from `100ffe4` to `0f27c1a`.
  - [Release notes](https://github.com/kward/shunit2/releases)
  - [Commits](https://github.com/kward/shunit2/compare/100ffe4dda539ebbe4ae9867132f08eeee8e80cb...0f27c1ac71998835ff41d335d45079d6eb2a4bfe)
  
  updated-dependencies:
  - dependency-name: tests/unit/shunit2
    dependency-type: direct:production
  ...
- Bump tests/unit/shunit2 from `0f27c1a` to `6d31ca9`
 ([97118cf](https://github.com/mendersoftware/mender-configure-module/commit/97118cf99fecac81e865bbcb0d22d7f024cda730))  by @dependabot[bot]




  Bumps [tests/unit/shunit2](https://github.com/kward/shunit2) from `0f27c1a` to `6d31ca9`.
  - [Release notes](https://github.com/kward/shunit2/releases)
  - [Commits](https://github.com/kward/shunit2/compare/0f27c1ac71998835ff41d335d45079d6eb2a4bfe...6d31ca9b0858cda66843057d08ea499b58c903d6)
  
  updated-dependencies:
  - dependency-name: tests/unit/shunit2
    dependency-version: 6d31ca9b0858cda66843057d08ea499b58c903d6
    dependency-type: direct:production
  ...
- Bump tests/unit/shunit2 from `6d31ca9` to `e35296d`
 ([67bda00](https://github.com/mendersoftware/mender-configure-module/commit/67bda0056d87dd4ef08c71dcf83cf15f2d57c53e))  by @dependabot[bot]




  Bumps [tests/unit/shunit2](https://github.com/kward/shunit2) from `6d31ca9` to `e35296d`.
  - [Release notes](https://github.com/kward/shunit2/releases)
  - [Commits](https://github.com/kward/shunit2/compare/6d31ca9b0858cda66843057d08ea499b58c903d6...e35296d3be2bcde770f2989d9c09fd1a2af6b567)
  
  updated-dependencies:
  - dependency-name: tests/unit/shunit2
    dependency-version: e35296d3be2bcde770f2989d9c09fd1a2af6b567
    dependency-type: direct:production
  ...

## mender-binary-delta master (2026-02-19)

### master - 2026-02-19


#### Bug fixes


- Convert the boot partition numbers to int before comparison.
([MEN-8043](https://northerntech.atlassian.net/browse/MEN-8043)) ([99e8d24](https://github.com/mendersoftware/mender-binary-delta/commit/99e8d2487ab369194959f22a93b63c20141014e3))  by @jo-lund





- Fix segfault when failing to get part number during install
 ([951ed28](https://github.com/mendersoftware/mender-binary-delta/commit/951ed289a052dcc00b1f4ef4dfb4cc3538c3abb8))  by @lluiscampos






  This was a hidden bug that surfaced now while fixing the support for
  PARTUUID and PARTLABEL. Or, in other words, when handling Mender
  configuration with partitions that do not end with a number. In this
  case pass_num is NULL and xasprintf will try to dereference it.
- Correctly apply deltas with PARTUUID and PARTLABEL configuration
([MEN-7160](https://northerntech.atlassian.net/browse/MEN-7160)) ([f146c78](https://github.com/mendersoftware/mender-binary-delta/commit/f146c786501db209bbfc80785bfe682ec658525d))  by @lluiscampos







  This fixes the bug where mender-binary-delta fails to apply the delta
  when partitions are configured with PARTUUID or PARTLABEL options.
  
  Fixes the issue by first resolving the device symlinks like
  /dev/disk/by-partuuid/*, /dev/disk/by-partlabel/*, and /dev/root to
  their actual device paths (e.g., /dev/sda2, /dev/mmcblk0p2) and then
  extracting the partition numbers.
  
  Related to https://github.com/mendersoftware/mender/pull/1613
- Add missing license to the OS licenses manifest
 ([f07a277](https://github.com/mendersoftware/mender-binary-delta/commit/f07a277c74210991f85f610c79b186e3eab5fe0b))  by @lluiscampos









#### Security


- Bump tests/integration/mender_integration
 ([70acccb](https://github.com/mendersoftware/mender-binary-delta/commit/70acccb6def4365950c0249e98ad3a1ad17bd5d0))  by @dependabot[bot]




  Bumps [tests/integration/mender_integration](https://github.com/mendersoftware/integration) from `36839fd` to `1501222`.
  - [Commits](https://github.com/mendersoftware/integration/compare/36839fdcf687db9f587a9d1fc6bc56d356af5927...1501222d8c2594edea2c5e0f9c80facce36dfa05)
  
  updated-dependencies:
  - dependency-name: tests/integration/mender_integration
    dependency-type: direct:production
  ...
- Bump tests/integration/mender_test_containers
 ([3cedd76](https://github.com/mendersoftware/mender-binary-delta/commit/3cedd762f9fec2498ff77dfbcad960b474343f5a))  by @dependabot[bot]




  Bumps [tests/integration/mender_test_containers](https://github.com/mendersoftware/mender-test-containers) from `4adf634` to `bc74861`.
  - [Commits](https://github.com/mendersoftware/mender-test-containers/compare/4adf6344339c48ed581892e7cc1b2c6bb19bcf80...bc748616607384b75a37931592cff16b08aa1f93)
  
  updated-dependencies:
  - dependency-name: tests/integration/mender_test_containers
    dependency-type: direct:production
  ...
- Bump tests/unit/cmocka from `2206c22` to `f9e5b1f`
 ([fa0c0eb](https://github.com/mendersoftware/mender-binary-delta/commit/fa0c0ebd02a74e6ab46c9c0b1e0e0846f35e6f73))  by @dependabot[bot]




  Bumps tests/unit/cmocka from `2206c22` to `f9e5b1f`.
  
  updated-dependencies:
  - dependency-name: tests/unit/cmocka
    dependency-type: direct:production
  ...
- Bump libntech from `8b72e12` to `58705c5`
 ([e4a2ecf](https://github.com/mendersoftware/mender-binary-delta/commit/e4a2ecf9abdbbe590361a2e008d07665e47a6620))  by @dependabot[bot]




  Bumps [libntech](https://github.com/NorthernTechHQ/libntech) from `8b72e12` to `58705c5`.
  - [Release notes](https://github.com/NorthernTechHQ/libntech/releases)
  - [Commits](https://github.com/NorthernTechHQ/libntech/compare/8b72e12cb0b65e1cb424f805ded839b80ac53d93...58705c5515d4c6f8481eb8c0c70e1e3cf557f109)
  
  updated-dependencies:
  - dependency-name: libntech
    dependency-type: direct:production
  ...
- Bump tests/unit/cmocka from `f9e5b1f` to `2453c23`
 ([501379b](https://github.com/mendersoftware/mender-binary-delta/commit/501379b24a885be5c4209ffefefd56db53897755))  by @dependabot[bot]




  Bumps tests/unit/cmocka from `f9e5b1f` to `2453c23`.
  
  updated-dependencies:
  - dependency-name: tests/unit/cmocka
    dependency-type: direct:production
  ...
- Bump libntech from `58705c5` to `329361a`
 ([aa91c89](https://github.com/mendersoftware/mender-binary-delta/commit/aa91c894a5f21b080dd0a2b506cff651aa679c63))  by @dependabot[bot]




  Bumps [libntech](https://github.com/NorthernTechHQ/libntech) from `58705c5` to `329361a`.
  - [Release notes](https://github.com/NorthernTechHQ/libntech/releases)
  - [Commits](https://github.com/NorthernTechHQ/libntech/compare/58705c5515d4c6f8481eb8c0c70e1e3cf557f109...329361aa207512069f9df17981c78e5397f2f8b5)
  
  updated-dependencies:
  - dependency-name: libntech
    dependency-type: direct:production
  ...
- Bump libntech from `329361a` to `13a9e99`
 ([d1d511f](https://github.com/mendersoftware/mender-binary-delta/commit/d1d511fb51568688bd6f6894332848652e957ca7))  by @dependabot[bot]




  Bumps [libntech](https://github.com/NorthernTechHQ/libntech) from `329361a` to `13a9e99`.
  - [Release notes](https://github.com/NorthernTechHQ/libntech/releases)
  - [Commits](https://github.com/NorthernTechHQ/libntech/compare/329361aa207512069f9df17981c78e5397f2f8b5...13a9e9935013948ebc9889e631fec0149ae87932)
  
  updated-dependencies:
  - dependency-name: libntech
    dependency-type: direct:production
  ...
- Bump tests/unit/cmocka from `2453c23` to `8f3854a`
 ([99cdbbb](https://github.com/mendersoftware/mender-binary-delta/commit/99cdbbb815f66b294265eb9b6cbe5bc092769002))  by @dependabot[bot]




  Bumps [tests/unit/cmocka](https://gitlab.com/cmocka/cmocka) from `2453c23` to `8f3854a`.
  - [Commits](https://gitlab.com/cmocka/cmocka/compare/2453c2347580290ddde85f9074b0f9b08f2f9c2f...8f3854ab86db0451e10be9e1d1e156e905f34f44)
  
  updated-dependencies:
  - dependency-name: tests/unit/cmocka
    dependency-type: direct:production
  ...
- Bump tests/unit/cmocka from `8f3854a` to `fa9b644`
 ([ad2bc7d](https://github.com/mendersoftware/mender-binary-delta/commit/ad2bc7d2191e0fbbf56f7a85ad826caaa4ac0b91))  by @dependabot[bot]




  Bumps [tests/unit/cmocka](https://gitlab.com/cmocka/cmocka) from `8f3854a` to `fa9b644`.
  - [Commits](https://gitlab.com/cmocka/cmocka/compare/8f3854ab86db0451e10be9e1d1e156e905f34f44...fa9b6449c54f4defbad7e27e35b0ce8d6547d8b4)
  
  updated-dependencies:
  - dependency-name: tests/unit/cmocka
    dependency-type: direct:production
  ...
- Bump libntech from `13a9e99` to `4e45713`
 ([e913440](https://github.com/mendersoftware/mender-binary-delta/commit/e9134402b695256223057d7efe5f649cf1f48947))  by @dependabot[bot]




  Bumps [libntech](https://github.com/NorthernTechHQ/libntech) from `13a9e99` to `4e45713`.
  - [Release notes](https://github.com/NorthernTechHQ/libntech/releases)
  - [Commits](https://github.com/NorthernTechHQ/libntech/compare/13a9e9935013948ebc9889e631fec0149ae87932...4e45713d59f05d8f377dfe5f87d5cf84c688624b)
  
  updated-dependencies:
  - dependency-name: libntech
    dependency-type: direct:production
  ...
- Bump libntech from `4e45713` to `072bbcc`
 ([ecd814e](https://github.com/mendersoftware/mender-binary-delta/commit/ecd814e10db47e80f5a7ab7d57326261a28c8fd0))  by @dependabot[bot]




  Bumps [libntech](https://github.com/NorthernTechHQ/libntech) from `4e45713` to `072bbcc`.
  - [Release notes](https://github.com/NorthernTechHQ/libntech/releases)
  - [Commits](https://github.com/NorthernTechHQ/libntech/compare/4e45713d59f05d8f377dfe5f87d5cf84c688624b...072bbcc8d180510300972915c1d95eb3eccd3728)
  
  updated-dependencies:
  - dependency-name: libntech
    dependency-type: direct:production
  ...
- Bump libntech from `072bbcc` to `69e2624`
 ([53a23e0](https://github.com/mendersoftware/mender-binary-delta/commit/53a23e0228991b091a5c8eb8eb8c473b58f3a1a2))  by @dependabot[bot]




  Bumps [libntech](https://github.com/NorthernTechHQ/libntech) from `072bbcc` to `69e2624`.
  - [Release notes](https://github.com/NorthernTechHQ/libntech/releases)
  - [Commits](https://github.com/NorthernTechHQ/libntech/compare/072bbcc8d180510300972915c1d95eb3eccd3728...69e262461e19759141527d605be52da61fccc505)
  
  updated-dependencies:
  - dependency-name: libntech
    dependency-type: direct:production
  ...
- Bump submodules
 ([61cff5d](https://github.com/mendersoftware/mender-binary-delta/commit/61cff5d390cc138946a9d785252a3ce84ca3edd3))  by @danielskinstad




  Bump libntech:
  * 69e262461e19759141527d605be52da61fccc505 -> 5a62ba4fd32a9ecffb6f9d698e4f4981986c6cec
  
  Bump tests/integration/mender_test_containers:
  * fec8b87c72967bb526d59d98e01420de60d71176 -> 99219966a0a924d33fee379a61e542c2cda623cb
  
  Bump tests/integration/mender_integration:
  * 305cbf5b63785ec629b4e4ad657364516b479f74 -> 1ded978181876f2a5d027d28f2a7ec5a2f356091
  
  Bump tests/unit/cmocka:
  * fa9b6449c54f4defbad7e27e35b0ce8d6547d8b4 -> 66d319e98d1e2a6f5f0468397991d255b641cf2f




#### Build


- Update cloning link for cmocka, whose original has broken.
 ([535f8a4](https://github.com/mendersoftware/mender-binary-delta/commit/535f8a4a81872c51874df2a1471d16891f28ad6b))

## mender-container-modules main (2026-01-13)

First release of mender-container-modules

---
## Older releases

Previous to Mender Client 6.0, the release notes & changelog can be found in the pages for the individual components:

* [mender](20.Mender-Client/docs.md)
* [mender-connect](21.mender-connect/docs.md)
* [mender-configure-module](22.mender-configure-module/docs.md)
* [mender-flash](25.mender-flash/docs.md)
* [mender-binary-delta](50.mender-binary-delta/docs.md)
* [monitor-client](51.monitor-client/docs.md)

The following release notes & changelog are for `mender` repository alone, prior to Mender Client 6.0

## mender 5.0.3

_Released 11.03.2025_

### Changelogs

#### mender (5.0.3)

New changes in mender since 5.0.2:

##### Bug Fixes

* Fix an issue where a user-aborted deployment would reboot and rollback
  during e.g. download. This is fixed by adding a new state event, `DeploymentAborted`,
  which is posted when sending status updates to the server. Each state that sends
  deployment status now explicitly checks if the deployment is aborted and handles
  it accordingly.
  ([ME-527](https://northerntech.atlassian.net/browse/ME-527))
* Fix an issue where mender-update hangs when network connection is
  lost during artifact download. Implement a 5-minute timeout in `AsyncReadNextBodyPart`
  to allow the HTTP resumer to resume the download.
  ([MEN-8717](https://northerntech.atlassian.net/browse/MEN-8717))
* Add warning and instruction to use space for separating multiple `NO_PROXY` values
  ([ME-586](https://northerntech.atlassian.net/browse/ME-586))

##### Other

* Use the new package repositories
  ([QA-1090](https://northerntech.atlassian.net/browse/QA-1090))


## mender 5.0.2

_Released 07.24.2025_

### Changelogs

#### mender (5.0.2)

New changes in mender since 5.0.1:

##### Bug Fixes

* Fix issue where trailing bytes in an HTTP response
  break parsing of the future HTTP responses, resulting in `bad
  version` errors and failed HTTP requests
  ([MEN-8554](https://northerntech.atlassian.net/browse/MEN-8554))
* Make mender-inventory-geo work with both wget provided by busybox and full version of wget
  ([MEN-8548](https://northerntech.atlassian.net/browse/MEN-8548))


#### mender (5.0.1)

New changes in mender since 5.0.0:

##### Bug fixes

* Clear the inventory data hash on re-authentication
  ([MEN-7873](https://northerntech.atlassian.net/browse/MEN-7873))
* All errors on attempts to communicate with the server
  are retried with an exponential backoff. This aligns the behavior
  of the state machine with Mender Client 3.
  ([MEN-7938](https://northerntech.atlassian.net/browse/MEN-7938))
* Fix issue where any error in Sync state (triggered for
  example with an error in Sync_Enter state scripts) leaves the client
  stuck in idle state forever and no new polls for update nor submit of
  inventory would be attempted again.
  ([MEN-7900](https://northerntech.atlassian.net/browse/MEN-7900))
* Compile with Boost 1.87
  ([MEN-8051](https://northerntech.atlassian.net/browse/MEN-8051))
* Fix deployment on 32 bit systems when rootfs is larger than 4Gb
  ([MEN-8062](https://northerntech.atlassian.net/browse/MEN-8062))
* Use EscapeString when generating JSON for supplied artifact data
  ([MEN-7974](https://northerntech.atlassian.net/browse/MEN-7974))
* Set a maximum of two tries for `mender-inventory-geo` when
  gathering geo info to avoid hanging for many tries when gathering the
  inventory.


## mender 5.0.0

_Released 12.18.2024_

### Changelogs

#### mender (5.0.0)

New changes in mender since 4.0.5:

##### Bug fixes

* Fix a bug where a failure in checking the working directory
  will not exit cleanly from `Cleanup` state.
* changed bash to sh and updated code to be compatible with sh
  and the new parsing of passthrough args.
* Improve error messages when executable can't be found.
* Fall back on bootloader when boot env modification tool is broken.
* Don't hide out-of-space messages when streaming in update modules.
* Fix download failure to always do a proper
  cancellation and cleanup of internal HTTP stuctures to avoid
  breaking future HTTP requests. Fixes `bad_version` error.
  ([MEN-7810](https://northerntech.atlassian.net/browse/MEN-7810))
* Fix download resuming to reset the HTTP state and
  avoid repeatedly hitting the same error in case of a bad state
  ([MEN-7810](https://northerntech.atlassian.net/browse/MEN-7810))
* Fix inventory reporting of device_type to correctly select
  the file based on Mender configuration and Mender environment variables
* On failures attempting to communicate with the server when
  submitting inventory or polling for deployment, a backoff mechanism
  will cancel and take over for the `InventoryPollIntervalSeconds` and
  `UpdatePollIntervalSeconds` intervals. The maxmimum backoff interval
  is configured with `RetryPollIntervalSeconds`, and it will retry
  `RetryPollCount` times. This allows mender-update to recover quicker
  in case of potential race conditions, such as if mender-update starts
  polling before mender-auth has generated the key on first boot.
  ([MEN-7790](https://northerntech.atlassian.net/browse/MEN-7790))
* Resend the inventory when the device has reauthenticated
  ([MEN-7820](https://northerntech.atlassian.net/browse/MEN-7820))

##### Features

* Replace `--data` flag with `--datastore` flag. This aligns
  better with the environment variables with the same names. The old
  `--data` flag is still accepted for backwards compatibility, but note
  that it does not have the same meaning as the `MENDER_DATA_DIR`
  environment variable (hence the rename).
* Add mender-inventory-inventory script to default install.

  To list configured polling intervals in device inventory.
* Change the generated key from RSA to ED25519. This is
  generated if there is no key provided in the configuration file, and if
  and if there is no previously generated key. Existing keys won't be affected,
  so this will only affect installation in new devices.
  The motivation for this change is more efficient computation.
  ([MEN-7534](https://northerntech.atlassian.net/browse/MEN-7534))
* Add `--stop-before` flag which can be used with the
  `install`, `commit`, and `rollback` standalone commands to stop before
  certain states. Use `resume` to continue, which also supports the same
  flag. These are the allowed states:
  * `ArtifactInstall_Enter`
  * `ArtifactCommit_Enter`
  * `ArtifactCommit_Leave`
  * `ArtifactRollback_Enter`
  * `ArtifactFailure_Enter`
  * `Cleanup`
  The flag can be specified multiple times.
  ([MEN-7115](https://northerntech.atlassian.net/browse/MEN-7115))

##### Other

* Returns an error when passing type, or when passing
  metadata to docker-artifact gen, and overrides output path
  and name when passed as passthrough argument.
  ([MEN-7110](https://northerntech.atlassian.net/browse/MEN-7110))
* Move `deb`, `docker`, `rpm` and `script` Update Modules out
  from `mender` repository to `mender-update-modules` repository. From
  this version on, `mender` will ship by default only with `rootfs`,
  `file` and `directory` Update Modules (both in `meta-mender` recipes and
  Debian binary packages).
  ([MEN-7672](https://northerntech.atlassian.net/browse/MEN-7672))
* Add systemd mender-data-dir.service optionally installed
  with MENDER_DATA_DIR_SYSTEMD_UNIT CMake variable. This
  service historically has been in meta-mender repository and
  used elsewhere from there. By moving it to the source
  repository we'll have it better aligned with authd and
  updated services
* Fix an issue with tar archive parsing where the client
  erroneously interpreted zero-filled records at the end of the archive as
  invalid, throwing `Superfluous data at the end of the archive` error.
  ([MEN-7810](https://northerntech.atlassian.net/browse/MEN-7810))


## mender 4.0.7

_Released 03.27.2025_

### Changelogs

#### mender (4.0.7)

New changes in mender since 4.0.6:

##### Bug fixes

* Clear the inventory data hash on re-authentication
  ([MEN-7873](https://northerntech.atlassian.net/browse/MEN-7873))
* Compile with Boost 1.87
  ([MEN-8051](https://northerntech.atlassian.net/browse/MEN-8051))
* Fix deployment on 32 bit systems when rootfs is larger than 4Gb
  ([MEN-8062](https://northerntech.atlassian.net/browse/MEN-8062))
* Use EscapeString when generating JSON for supplied artifact data
  ([MEN-7974](https://northerntech.atlassian.net/browse/MEN-7974))
* Set a maximum of two tries for `mender-inventory-geo` when
  gathering geo info to avoid hanging for many tries when gathering the
  inventory.


## mender 4.0.6

_Released 12.20.2024_

### Changelogs

#### mender (4.0.6)

New changes in mender since 4.0.5:

##### Bug fixes

* Fix download failure to always do a proper
  cancellation and cleanup of internal HTTP stuctures to avoid
  breaking future HTTP requests. Fixes `bad_version` error.
  ([MEN-7810](https://northerntech.atlassian.net/browse/MEN-7810))
* Fix download resuming to reset the HTTP state and
  avoid repeatedly hitting the same error in case of a bad state
  ([MEN-7810](https://northerntech.atlassian.net/browse/MEN-7810))
* Fix inventory reporting of device_type to correctly select
  the file based on Mender configuration and Mender environment variables
* Resend the inventory when the device has reauthenticated
  ([MEN-7820](https://northerntech.atlassian.net/browse/MEN-7820))

##### Other

* Fix an issue with tar archive parsing where the client
  erroneously interpreted zero-filled records at the end of the archive as
  invalid, throwing `Superfluous data at the end of the archive` error.
  ([MEN-7810](https://northerntech.atlassian.net/browse/MEN-7810))


## mender 4.0.5

_Released 12.02.2024_

### Security fixes

* Fixed CVE-2024-55959 - Insecure permissions on private key file
  generated by the Mender Client. See the official announcement
  for more information:
  [mender.io/blog/cve-2024-55959](https://mender.io/blog/cve-2024-55959)

### Changelogs

#### mender (4.0.5)

New changes in mender since 4.0.4:

##### Bug fixes

* Fix crash when `Sync_Leave` returns error during a
  deployment. The error message would be:
  ```
  State machine event DeploymentStarted was not handled by any transition
  ```
  and would happen on the next deployment following the `Sync_Leave`
  error. With a long polling interval, this could cause the bug to be
  latent for quite a while.
  ([MEN-7379](https://northerntech.atlassian.net/browse/MEN-7379))
* Fix systemd race condition when restarting mender from
  `ArtifactReboot` script. The symptom would be an error message like:
  ```
  Process returned non-zero exit status: ArtifactReboot: Process exited with status 15
  ```
  And the `ArtifactReboot_Error` state scripts would be executed, even
  though they should not.
* Progress reader updates the output only when progressing
  ([MEN-7159](https://northerntech.atlassian.net/browse/MEN-7159))
* rootfs-image: Add missing filesystem sync when not using mender-flash.
* rootfs-image: Make it safe to roll back after `ArtifactCommit`.
* Fix error while loading OpenSSL config file, by explicitly
  initializing the SSL context prior to loading. Without the explicit
  initialisation of SSL, the config might not be properly loaded if e.g.
  it has sections specifying ssl settings. This was the case with the
  example configuration for OpenSSL 1.1.1w from Debian Bullseye.
  ([MEN-7549](https://northerntech.atlassian.net/browse/MEN-7549))
* Invalidate cached inventory data on unauthentication event
  to prevent an issue with which the client would not send inventory
  data to the server after being unauthorized and authorized again.
  ([MEN-7617](https://northerntech.atlassian.net/browse/MEN-7617))
* Fix possible integer overflow when dealing with large files
  on 32-bit platforms.
  ([MEN-7613](https://northerntech.atlassian.net/browse/MEN-7613))
* During Artifact header parsing, correctly report generic
  errors instead of returning "Multiple header entries found" error for
  any kind of error.
  ([MEN-7721](https://northerntech.atlassian.net/browse/MEN-7721))
* Verify the integrity of the `version` file content during
  Artifact parsing.
  ([MEN-7721](https://northerntech.atlassian.net/browse/MEN-7721))
* Fix potential integer underflow in Artifact's manifest parsing
  ([MEN-7722](https://northerntech.atlassian.net/browse/MEN-7722))
* Limit file name length for the Artifact manifest
  ([MEN-7722](https://northerntech.atlassian.net/browse/MEN-7722))
* Ensured strict permissions of private key files created by mender-auth
  ([MEN-7752](https://northerntech.atlassian.net/browse/MEN-7752))

##### Other

* Clarify in the update module protocol documentation that
  going into `ArtifactRollback` is still possible after an
  `ArtifactCommit`, and it must still roll back successfully. While this
  may seem like it introduces new requirements into a stable protocol,
  it's important to remember that this was always possible, if the
  device lost power after having run the steps inside `ArtifactCommit`,
  but before the device could record having done so. In this case
  `ArtifactRollback` would be the next step, so this is just formalizing
  this possibility and subsequent requirement.
* Add info level messages for inventory sent/skipped


## mender 4.0.4

_Released 08.01.2024_

### Changelogs

#### mender (4.0.4)

New changes in mender since 4.0.3:

##### Bug fixes

* Make crypto load and use the openssl.cnf file
  ([MEN-7353](https://northerntech.atlassian.net/browse/MEN-7353))
* Basic authentication (https://user:password@host/) is now supported for proxy URLs and connections
  ([MEN-7402](https://northerntech.atlassian.net/browse/MEN-7402))


## mender 4.0.3

_Released 06.12.2024_

### Changelogs

#### mender (4.0.3)

New changes in mender since 4.0.2:

##### Bug fixes

* Amend default paths printed in CLI help pages. Previously
  they could be modified by user environment variables.
  ([MEN-7133](https://northerntech.atlassian.net/browse/MEN-7133))
* Fix committing mender-update artifacts when using mender-partuuid
* Invalid Range request when content_length is 0 (unknown)
* Fix error which could sometimes happen with restrictive
  firewalls, resulting in this output:
  ```
  Programming error, should not happen: Assert `deployment_id != ""`
  ```
  ([MEN-7327](https://northerntech.atlassian.net/browse/MEN-7327))

##### Features

* Add `SYSTEMD_UNIT_DIR` CMake variable.

  Use it to customize the location of the systemd unit files. Usually it
  is set to `/lib/systemd/system`.


## mender 4.0.2

_Released 03.21.2024_

### Changelogs

#### mender (4.0.2)

New changes in mender since 4.0.1:

##### Bug fixes

* Submit inventory as soon as the device is accepted.
* Fix line processing of data when reading a single byte

  When reading a single byte it was not being saved in the trailing line
  and, eventually, lost.


## mender 4.0.1

_Released 02.12.2024_

### Statistics

| Developers with the most changesets | |
|---|---|
| Kristian Amlie | 2 (66.7%) |
| Sebastian Opsahl | 1 (33.3%) |

| Developers with the most changed lines | |
|---|---|
| Sebastian Opsahl | 54 (94.7%) |
| Kristian Amlie | 3 (5.3%) |

| Developers with the most lines removed | |
|---|---|
| Sebastian Opsahl | 7 (12.3%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 3 (100.0%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 57 (100.0%) |

| Employers with the most hackers (total 2) | |
|---|---|
| Northern.tech | 2 (100.0%) |

### Changelogs

#### mender (4.0.1)

New changes in mender since 4.0.0:

##### Bug fixes

* Unify meta-data element support in mender-artifact and C++ parser, and relax to accept all valid JSON
  ([MEN-6199](https://northerntech.atlassian.net/browse/MEN-6199))
* Artifact name is now properly marked as "INCONSISTENT" if
  there is an error in the `ArtifactFailure_Leave` script during an
  installation.
* Update incorrect default value for `--data` flag in help screen.


## mender 4.0.0

_Released 01.15.2024_

### Statistics

A total of 70335 lines added, 61546 removed (delta 8789)

| Developers with the most changesets | |
|---|---|
| Kristian Amlie | 478 (47.5%) |
| Ole Petter Orhagen | 246 (24.4%) |
| Vratislav Podzimek | 155 (15.4%) |
| Lluis Campos | 104 (10.3%) |
| Peter Grzybowski | 4 (0.4%) |
| Lars Erik Wik | 4 (0.4%) |
| Lukasz Finster | 3 (0.3%) |
| Adam Duskett | 2 (0.2%) |
| Alan | 2 (0.2%) |
| Alf-Rune Siqveland | 2 (0.2%) |

| Developers with the most changed lines | |
|---|---|
| Kristian Amlie | 78431 (66.4%) |
| Ole Petter Orhagen | 15419 (13.1%) |
| Vratislav Podzimek | 14779 (12.5%) |
| Lluis Campos | 7198 (6.1%) |
| Peter Grzybowski | 1055 (0.9%) |
| Adam Duskett | 535 (0.5%) |
| Lars Erik Wik | 330 (0.3%) |
| Lukasz Finster | 138 (0.1%) |
| Josef Holzmayr | 114 (0.1%) |
| Alf-Rune Siqveland | 42 (0.0%) |

| Developers with the most lines removed | |
|---|---|
| Kristian Amlie | 19656 (31.9%) |
| Adam Duskett | 132 (0.2%) |
| Josef Holzmayr | 81 (0.1%) |
| Fabio Tranchitella | 1 (0.0%) |

| Developers with the most signoffs (total 6) | |
|---|---|
| Vratislav Podzimek | 3 (50.0%) |
| Ole Petter Orhagen | 2 (33.3%) |
| Kristian Amlie | 1 (16.7%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 1001 (99.4%) |
| Tronel | 3 (0.3%) |
| aduskett@gmail.com | 2 (0.2%) |
| BlackBerry Limited | 1 (0.1%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 117379 (99.4%) |
| aduskett@gmail.com | 535 (0.5%) |
| Tronel | 138 (0.1%) |
| BlackBerry Limited | 32 (0.0%) |

| Employers with the most signoffs (total 6) | |
|---|---|
| Northern.tech | 6 (100.0%) |

| Employers with the most hackers (total 16) | |
|---|---|
| Northern.tech | 13 (81.2%) |
| aduskett@gmail.com | 1 (6.2%) |
| Tronel | 1 (6.2%) |
| BlackBerry Limited | 1 (6.2%) |

### Changelogs

#### mender (4.0.0)

Mender client version 4.0.0 has been completely rewritten from scratch in C++. To ensure a
successful migration, there are a number of changes which are important to pay attention to. The
complete list of changes is below, but for a more user friendly migration guide, please see the
[Upgrading guide](https://docs.mender.io/3.7/client-installation/install-with-debian-package/upgrading)
in the Mender documentation.

New changes in mender since 3.5.2:

##### Bug fixes

* disabled implicit conversion form Error to bool
  ([MEN-6409](https://northerntech.atlassian.net/browse/MEN-6409))
* README: add build instructions for C++-client
* latest openssl reports "no such file" if the cert doesn't exist
* Rootfs scripts in the C++ client are checked in the same way as
  `Artifact` scripts, and hence, we are now moving it to support only `version 3`.
  While in the old `Golang` client both version `2` and `3` were supported.
  ([MEN-6671](https://northerntech.atlassian.net/browse/MEN-6671))
* The client no longer erronously commits a rootfs-image
  artifact after being restarted using `systemctl restart` in the
  `ArtifactReboot` state.
  ([MEN-6633](https://northerntech.atlassian.net/browse/MEN-6633))

##### Features

* The client's HSM crypto-module support is changed so that the
  `PrivateKey` used for `authentication` is always taken from the configurations:
  `security.AuthPrivateKey`, and the `HttpsClient.private_key` is only used as the
  key for the associated certificate `HttpsClient.client_certificate`. The two can
  still use the same key, but this means now that you add the same key `url` in
  both places.
  ([MEN-6668](https://northerntech.atlassian.net/browse/MEN-6668))

##### Other

* The rootfs-image updater is no longer built in, but is an
  Update Module, available under the name `rootfs-image`.
* Remove `DbusEnabled` config option.

  Mender now always depends on DBus.
  ([MEN-6662](https://northerntech.atlassian.net/browse/MEN-6662))
* Remove `BootUtilitiesGetNextActivePart` and
  `BootUtilitiesSetActivePart` config options. These are not necessary
  anymore since the choice of tool, including its calling arguments, can
  be programmed directly into each update module instead.
  ([MEN-6662](https://northerntech.atlassian.net/browse/MEN-6662))
* Update Control support has been removed from the client.
  ([MEN-6647](https://northerntech.atlassian.net/browse/MEN-6647))
* `--forcebootstrap` is not a global cli option anymore,
  but an option specific to `mender-auth daemon` and `mender-auth
  bootstrap` commands.
  ([MEN-6679](https://northerntech.atlassian.net/browse/MEN-6679))
* Mender daemon does not anymore integrate with `syslog`,
  handling the logs is responsibility of `systemd` or the caller.
  ([MEN-6679](https://northerntech.atlassian.net/browse/MEN-6679))
* Global flag `--no-syslog` is removed.
  ([MEN-6679](https://northerntech.atlassian.net/browse/MEN-6679))
* Remove `--passphrase-file` option from command scopes where
  it has no use. Move it to `mender-auth daemon` and `mender-auth
  bootstrap` commands.
  ([MEN-6679](https://northerntech.atlassian.net/browse/MEN-6679))
* mention the deprecation of control maps
  ([MEN-6648](https://northerntech.atlassian.net/browse/MEN-6648))
* Mender client does not use HTTP Keep-Alive anymore. The
  related configuration option `Connectivity` is deprecated. The TCP
  connection will be terminated as soon as the HTTP request/response is
  finished, and every subsequent HTTP request will open a new TCP
  connection.
  ([MEN-6862](https://northerntech.atlassian.net/browse/MEN-6862))
* systemd service `mender-client` does not exist anymore.
  Dependencies shall depend either `mender-authd` or `mender-updated`.
  ([MEN-6858](https://northerntech.atlassian.net/browse/MEN-6858))


## mender 3.5.3

_Released 06.12.2024_

### Changelogs

#### mender (3.5.3)

New changes in mender since 3.5.1:

##### Bug fixes

* Fix a rare bug which could corrupt the very end of a
  rootfs-image update on a sudden powerloss. The circumstances where it
  could happen are quite specific: The filesystem size in the update
  need to *not* be a multiple of the native sector size, which is very
  uncommon. The sector size is typically 512 bytes almost everywhere,
  and hence filesystem also follow this block size, if not bigger. The
  exception is raw Flash/UBI devices, where the sector size can be much
  larger, and not a power of two, and hence these platforms may be more
  susceptible.
* doing so return 1 in Download_Enter state scripts aborts instead of retrying in an endless loop
  ([MEN-6319](https://northerntech.atlassian.net/browse/MEN-6319))
* Fix so the Download_error state script gets executed for failures due to signature
  ([MEN-6402](https://northerntech.atlassian.net/browse/MEN-6402))
* recover from a corrupted database renaming it as `broken` and starting with a new empty one
  ([MEN-6848](https://northerntech.atlassian.net/browse/MEN-6848))


## mender 3.5.2

_Released 12.28.2023_

### Statistics

| Developers with the most changesets | |
|---|---|
| Lluis Campos | 1 (33.3%) |
| Peter Grzybowski | 1 (33.3%) |
| Kristian Amlie | 1 (33.3%) |

| Developers with the most changed lines | |
|---|---|
| Peter Grzybowski | 39 (78.0%) |
| Kristian Amlie | 10 (20.0%) |
| Lluis Campos | 1 (2.0%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 3 (100.0%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 50 (100.0%) |

| Employers with the most hackers (total 3) | | | |
|---|---|
| Northern.tech | 3 (100.0%) |

### Changelogs

#### mender (3.5.2)

New changes in mender since 3.5.1:

##### Bug fixes

* Fix a rare bug which could corrupt the very end of a
  rootfs-image update on a sudden powerloss. The circumstances where it
  could happen are quite specific: The filesystem size in the update
  need to *not* be a multiple of the native sector size, which is very
  uncommon. The sector size is typically 512 bytes almost everywhere,
  and hence filesystem also follow this block size, if not bigger. The
  exception is raw Flash/UBI devices, where the sector size can be much
  larger, and not a power of two, and hence these platforms may be more
  susceptible.

##### Features

* recover from a corrupted database renaming it as `broken` and starting with a new empty one
  ([MEN-6848](https://northerntech.atlassian.net/browse/MEN-6848))


## mender 3.5.1

_Released 07.28.2023_

### Statistics

A total of 1119 lines added, 1075 removed (delta 44)

| Developers with the most changesets | |
|---|---|
| Peter Grzybowski | 5 (38.5%) |
| Lluis Campos | 3 (23.1%) |
| Kristian Amlie | 2 (15.4%) |
| Alf-Rune Siqveland | 1 (7.7%) |
| Marcin Pasinski | 1 (7.7%) |
| Ole Petter Orhagen | 1 (7.7%) |

| Developers with the most changed lines | |
|---|---|
| Peter Grzybowski | 1024 (88.5%) |
| Alf-Rune Siqveland | 41 (3.5%) |
| Lluis Campos | 36 (3.1%) |
| Ole Petter Orhagen | 24 (2.1%) |
| Marcin Pasinski | 22 (1.9%) |
| Kristian Amlie | 10 (0.9%) |

| Developers with the most lines removed | |
|---|---|
| Ole Petter Orhagen | 23 (2.1%) |
| Lluis Campos | 2 (0.2%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 13 (100.0%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 1157 (100.0%) |

| Employers with the most hackers (total 6) | |
|---|---|
| Northern.tech | 6 (100.0%) |

### Changelogs

#### mender (3.5.1)

New changes in mender since 3.5.0:

##### Bug fixes

* Authmanager can blocks forever on unbuffered chan
  ([MEN-6621](https://northerntech.atlassian.net/browse/MEN-6621))
* do a full commonInit only when needed.
  ([MEN-6618](https://northerntech.atlassian.net/browse/MEN-6618))

##### Features

* inventory script: parse and support location data.
  ([MEN-5915](https://northerntech.atlassian.net/browse/MEN-5915))

##### Other

* mender-artifact set to 3.10.x in go.mod


## mender 3.5.0

_Released 02.20.2023_

### Statistics

A total of 2751 lines added, 849 removed (delta 1902)

| Developers with the most changesets | |
|---|---|
| Lluis Campos | 16 (34.0%) |
| Kristian Amlie | 8 (17.0%) |
| Ole Petter Orhagen | 7 (14.9%) |
| Mikael Torp-Holte | 4 (8.5%) |
| Fabio Tranchitella | 3 (6.4%) |
| Josef Holzmayr | 2 (4.3%) |
| Alan | 2 (4.3%) |
| Marcin Pasinski | 1 (2.1%) |
| Alf-Rune Siqveland | 1 (2.1%) |
| Uri Ishon | 1 (2.1%) |

| Developers with the most changed lines | |
|---|---|
| Lluis Campos | 1543 (53.4%) |
| Mikael Torp-Holte | 522 (18.0%) |
| Kristian Amlie | 381 (13.2%) |
| Michael Ho | 154 (5.3%) |
| Fabio Tranchitella | 97 (3.4%) |
| Marcin Pasinski | 72 (2.5%) |
| Ole Petter Orhagen | 58 (2.0%) |
| Josef Holzmayr | 26 (0.9%) |
| Uri Ishon | 20 (0.7%) |
| Alan | 12 (0.4%) |

| Developers with the most lines removed | |
|---|---|
| Fabio Tranchitella | 43 (5.1%) |

| Developers with the most signoffs (total 3) | |
|---|---|
| Lluis Campos | 2 (66.7%) |
| Esteban Aguero Perez | 1 (33.3%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 45 (95.7%) |
| uishon@gmail.com | 1 (2.1%) |
| callmemikeh@gmail.com | 1 (2.1%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 2718 (94.0%) |
| callmemikeh@gmail.com | 154 (5.3%) |
| uishon@gmail.com | 20 (0.7%) |

| Employers with the most signoffs (total 3) | |
|---|---|
| Northern.tech | 3 (100.0%) |

| Employers with the most hackers (total 12) | |
|---|---|
| Northern.tech | 10 (83.3%) |
| callmemikeh@gmail.com | 1 (8.3%) |
| uishon@gmail.com | 1 (8.3%) |

### Changelogs

#### mender (3.5.0)

New changes in mender since 3.4.0:

##### Bug fixes

* The daemon no longer exits in the edge case where it cannot bring
  down the proxy server due to timeouts.
  ([ME-3](https://northerntech.atlassian.net/browse/ME-3))
* The websockets are no longer left trying to open a connection to the
  server, when the proxy server is shut down.
  ([ME-3](https://northerntech.atlassian.net/browse/ME-3))
* Expand the check for new openssl version
* systemd: Always try restarting the client if it exits.
  ([ME-33](https://northerntech.atlassian.net/browse/ME-33))
* websocket connectivity through http-proxy if configured

  Enables websocket connections to be established through an
  http-proxy configurable by setting the `HTTPS_PROXY` environment
  variable. This renders services that relies on websocket
  connections, such as `mender-connect`, compatible with
  http-proxying. ([ME-5](https://northerntech.atlassian.net/browse/ME-5))
* client not to skip custom TLS if an http-proxy is configured

  Previously, Mender client supported http-proxying but ignored
  custom TLS client configuration if present. This change renders
  any custom TLS configurations, such as Mutual TLS, compatible with
  http-proxying.
  ([MEN-6009](https://northerntech.atlassian.net/browse/MEN-6009))
* do not ignore software versioning opts in the module artifact gens
  ([MEN-6026](https://northerntech.atlassian.net/browse/MEN-6026))
* Add `--no-syslog` to the service file to ensure no
  duplicate log messages in the journal.
  ([MEN-6070](https://northerntech.atlassian.net/browse/MEN-6070))
* change mender-inventory-hostinfo to use the output of hostname

##### Features

* Install bootstrap Artifact on first start-up.

  On start-up, Mender checks for the existence of an special bootstrap
  Artifact in path `/var/lib/mender/bootstrap.mender` and installs it in
  order to initialize the device database.

  This applies both for `daemon` start and cli commands `bootstrap` and
  `install`.

  The Artifact is not installed if the device already has a database. When
  the Artifact is not found (and the database is empty) the database is
  initialized with `artifact-name=unknown`.

  In addition, Mender can also understand other kinds of "empty" Artifacts
  and install them either in managed or standalone modes.
  ([MEN-2583](https://northerntech.atlassian.net/browse/MEN-2583))
* Remove support for `artifact_info` file. The initial artifact
  name will be populated in the database using a bootstrap Artifact.
  ([MEN-2583](https://northerntech.atlassian.net/browse/MEN-2583))
* do not check if the artifact is already installed
  ([MEN-6129](https://northerntech.atlassian.net/browse/MEN-6129))
* Support multiple verifications keys

  https://hub.mender.io/t/multiple-artifactverifykeys/4309/6

  Creates a new client config parameter called ArtifactVerifyKeys that is
  a list of paths to keys. Any matching key can be used to verify an
  artifact - e.g. if 5 verification keys are provided, only 1 needs to
  match to verify the artifact.
* Add a thread: <proxy> field to the proxy logger

  Now the proxy logger stands out in the logs more, and can thus be filtered
  easier with tools parsing structured logs. This means that a log line from the
  `proxy` thread goes from looking like:

  ```
  Oct 05 08:50:06 qemux86-64 mender[259]: time="2022-10-05T08:50:06Z" level=error msg="error forwarding from client to backend: websocket: close 1006 (abnormal closure): unexpected EOF"
  ```

  To:

  ```
  Oct 05 08:50:06 qemux86-64 mender[259]: time="2022-10-05T08:50:06Z" level=error thread="proxy" msg="error forwarding from client to backend: websocket: close 1006 (abnormal closure): unexpected EOF"
  ```
* The default folders (`/etc/mender`, `/usr/share/mender` and
  `/var/lib/mender`) can now be overridden through the environment
  variables: `MENDER_CONF_DIR`, `MENDER_DATA_DIR`, `MENDER_DATASTORE_DIR`.
* Add zstd compression support

##### Other

* Replace obsolescent `egrep` with `grep -E` in inventory script


## mender 3.4.0

_Released 09.25.2022_

### Statistics

A total of 1308 lines added, 668 removed (delta 640)

| Developers with the most changesets | |
|---|---|
| Kristian Amlie | 7 (22.6%) |
| Mikael Torp-Holte | 4 (12.9%) |
| Alf-Rune Siqveland | 3 (9.7%) |
| Lluis Campos | 2 (6.5%) |
| Ole Petter Orhagen | 2 (6.5%) |
| Fabio Tranchitella | 2 (6.5%) |
| Maciej Tomczuk | 2 (6.5%) |
| Domenic Rodriguez | 2 (6.5%) |
| Peter Grzybowski | 2 (6.5%) |
| Drew Moseley | 2 (6.5%) |

| Developers with the most changed lines | |
|---|---|
| Lluis Campos | 721 (51.8%) |
| Kristian Amlie | 362 (26.0%) |
| Alf-Rune Siqveland | 128 (9.2%) |
| Ole Petter Orhagen | 57 (4.1%) |
| Maciej Tomczuk | 43 (3.1%) |
| Mikael Torp-Holte | 24 (1.7%) |
| Domenic Rodriguez | 20 (1.4%) |
| Peter Grzybowski | 11 (0.8%) |
| Drew Moseley | 8 (0.6%) |
| Michael Ho | 8 (0.6%) |

| Developers with the most lines removed | |
|---|---|
| Ole Petter Orhagen | 24 (3.6%) |
| Jonas Vautherin | 3 (0.4%) |
| Kristian Amlie | 2 (0.3%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 25 (80.6%) |
| Gecko Robotics | 2 (6.5%) |
| drew@moseleynet.net | 2 (6.5%) |
| callmemikeh@gmail.com | 1 (3.2%) |
| jonas.vautherin@protonmail.ch | 1 (3.2%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 1350 (97.1%) |
| Gecko Robotics | 20 (1.4%) |
| drew@moseleynet.net | 8 (0.6%) |
| callmemikeh@gmail.com | 8 (0.6%) |
| jonas.vautherin@protonmail.ch | 5 (0.4%) |

| Employers with the most hackers (total 13) | |
|---|---|
| Northern.tech | 9 (69.2%) |
| Gecko Robotics | 1 (7.7%) |
| drew@moseleynet.net | 1 (7.7%) |
| callmemikeh@gmail.com | 1 (7.7%) |
| jonas.vautherin@protonmail.ch | 1 (7.7%) |

### Changelogs

#### mender (3.4.0)

New changes in mender since 3.3.0:

##### Bug fixes

* setenv: Fix script input syntax.
* rootfs-image-v2: Make sure to set mender_boot_part_hex
* By default we bind to 127.0.0.1:0 instead of localhost.
* Over D-Bus we return the ProxyHost equal to 127.0.0.1
* Upgrade openssl dependency to fix cast error in recent Go.
* If paused before ArtifactReboot, and then manually
  rebooting the device outside of Mender, the client will properly
  resume the update now, instead of failing and rolling back.
  ([MEN-5709](https://northerntech.atlassian.net/browse/MEN-5709))
* Append log entries to syslog at the correct level
* The client update and inventory checks are now unaffected by the use
  of the `check-update` and `send-inventory` commands. While previously, this
  would both move the intervals at which checks we're done, and also extend them
  beyond the expected polling intervals configured.
  ([MEN-5547](https://northerntech.atlassian.net/browse/MEN-5547))
* Resolve symlinks for /dev/disk/by-partlabel

##### Features

* Add DaemonLogLevel parameter in configuration file
  ([MEN-5583](https://northerntech.atlassian.net/browse/MEN-5583))

##### Other

* Upgrade mender-artifact library to v0.0.0-20220913084855-9ed8ad0d53d0


## mender 3.3.2

_Released 03.10.2023_

### Statistics

A total of 599 lines added, 142 removed (delta 457)

| Developers with the most changesets | |
|---|---|
| Mikael Torp-Holte | 3 (23.1%) |
| Kristian Amlie | 2 (15.4%) |
| Lluis Campos | 2 (15.4%) |
| Ole Petter Orhagen | 2 (15.4%) |
| Alf-Rune Siqveland | 1 (7.7%) |
| Fabio Tranchitella | 1 (7.7%) |
| Josef Holzmayr | 1 (7.7%) |
| Alan | 1 (7.7%) |

| Developers with the most changed lines | |
|---|---|
| Mikael Torp-Holte | 521 (86.5%) |
| Lluis Campos | 55 (9.1%) |
| Ole Petter Orhagen | 8 (1.3%) |
| Josef Holzmayr | 8 (1.3%) |
| Kristian Amlie | 3 (0.5%) |
| Alf-Rune Siqveland | 3 (0.5%) |
| Fabio Tranchitella | 3 (0.5%) |
| Alan | 1 (0.2%) |

| Developers with the most signoffs (total 3) | |
|---|---|
| Lluis Campos | 3 (100.0%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 13 (100.0%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 602 (100.0%) |

| Employers with the most signoffs (total 3) | |
|---|---|
| Northern.tech | 3 (100.0%) |

| Employers with the most hackers (total 8) | |
|---|---|
| Northern.tech | 8 (100.0%) |

### Changelogs

#### mender (3.3.2)

New changes in mender since 3.3.1:

##### Bug fixes

* Expand the check for new openssl version
* systemd: Always try restarting the client if it exits.
  ([ME-33](https://northerntech.atlassian.net/browse/ME-33))
* websocket connectivity through http-proxy if configured

  Enables websocket connections to be established through an
  http-proxy configurable by setting the `HTTPS_PROXY` environment
  variable. This renders services that relies on websocket
  connections, such as `mender-connect`, compatible with
  http-proxying.
  ([ME-5](https://northerntech.atlassian.net/browse/ME-5))
* client not to skip custom TLS if an http-proxy is configured

  Previously, Mender client supported http-proxying but ignored
  custom TLS client configuration if present. This change renders
  any custom TLS configurations, such as Mutual TLS, compatible with
  http-proxying.
  ([MEN-6009](https://northerntech.atlassian.net/browse/MEN-6009))
* do not ignore software versioning opts in the module artifact gens
  ([MEN-6026](https://northerntech.atlassian.net/browse/MEN-6026))

##### Other

* Replace obsolescent `egrep` with `grep -E` in inventory script


## mender 3.3.1

_Released 10.19.2022_

### Statistics

A total of 628 lines added, 238 removed (delta 390)

| Developers with the most changesets | |
|---|---|
| Ole Petter Orhagen | 5 (31.2%) |
| Kristian Amlie | 5 (31.2%) |
| Peter Grzybowski | 2 (12.5%) |
| Michael Ho | 1 (6.2%) |
| Mikael Torp-Holte | 1 (6.2%) |
| Lluis Campos | 1 (6.2%) |
| Maciej Tomczuk | 1 (6.2%) |

| Developers with the most changed lines | |
|---|---|
| Lluis Campos | 418 (64.0%) |
| Ole Petter Orhagen | 92 (14.1%) |
| Kristian Amlie | 82 (12.6%) |
| Maciej Tomczuk | 40 (6.1%) |
| Peter Grzybowski | 11 (1.7%) |
| Michael Ho | 8 (1.2%) |
| Mikael Torp-Holte | 2 (0.3%) |

| Developers with the most lines removed | |
|---|---|
| Ole Petter Orhagen | 2 (0.8%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 15 (93.8%) |
| callmemikeh@gmail.com | 1 (6.2%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 645 (98.8%) |
| callmemikeh@gmail.com | 8 (1.2%) |

| Employers with the most hackers (total 7) | |
|---|---|
| Northern.tech | 6 (85.7%) |
| callmemikeh@gmail.com | 1 (14.3%) |

### Changelogs

#### mender (3.3.1)

New changes in mender since 3.3.0:

##### Bug fixes

* Upgrade openssl dependency to fix cast error in recent Go.
* If paused before ArtifactReboot, and then manually
  rebooting the device outside of Mender, the client will properly
  resume the update now, instead of failing and rolling back.
  ([MEN-5709](https://northerntech.atlassian.net/browse/MEN-5709))
* The client update and inventory checks are now unaffected by the use
  of the `check-update` and `send-inventory` commands. While previously, this
  would both move the intervals at which checks we're done, and also extend them
  beyond the expected polling intervals configured.
  ([MEN-5547](https://northerntech.atlassian.net/browse/MEN-5547))
* Append log entries to syslog at the correct level
* By default we bind to 127.0.0.1:0 instead of localhost.
* Over D-Bus we return the ProxyHost equal to 127.0.0.1
* Resolve symlinks for /dev/disk/by-partlabel
* The daemon no longer exits in the edge case where it cannot bring
  down the proxy server due to timeouts.
* The websockets are no longer left trying to open a connection to the
  server, when the proxy server is shut down.


## mender 3.3.0

_Released 06.14.2022_

### Statistics

A total of 928 lines added, 608 removed (delta 320)

| Developers with the most changesets | |
|---|---|
| Ole Petter Orhagen | 13 (43.3%) |
| Peter Grzybowski | 6 (20.0%) |
| Kristian Amlie | 4 (13.3%) |
| Domenic Rodriguez | 2 (6.7%) |
| Fabio Tranchitella | 1 (3.3%) |
| Mikael Torp-Holte | 1 (3.3%) |
| Sven Schermer | 1 (3.3%) |
| Lluis Campos | 1 (3.3%) |
| Adam Duskett | 1 (3.3%) |

| Developers with the most changed lines | |
|---|---|
| Ole Petter Orhagen | 507 (46.6%) |
| Kristian Amlie | 284 (26.1%) |
| Peter Grzybowski | 249 (22.9%) |
| Domenic Rodriguez | 20 (1.8%) |
| Sven Schermer | 16 (1.5%) |
| Lluis Campos | 9 (0.8%) |
| Fabio Tranchitella | 2 (0.2%) |
| Mikael Torp-Holte | 1 (0.1%) |
| Adam Duskett | 1 (0.1%) |

| Developers with the most lines removed | |
|---|---|
| Kristian Amlie | 54 (8.9%) |
| Lluis Campos | 2 (0.3%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 26 (86.7%) |
| Gecko Robotics | 2 (6.7%) |
| Disruptive Technologies | 1 (3.3%) |
| aduskett@gmail.com | 1 (3.3%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 1052 (96.6%) |
| Gecko Robotics | 20 (1.8%) |
| Disruptive Technologies | 16 (1.5%) |
| aduskett@gmail.com | 1 (0.1%) |

| Employers with the most hackers (total 9) | |
|---|---|
| Northern.tech | 6 (66.7%) |
| Gecko Robotics | 1 (11.1%) |
| Disruptive Technologies | 1 (11.1%) |
| aduskett@gmail.com | 1 (11.1%) |

### Changelogs

#### mender (3.3.0)

New changes in mender since 3.2.1:

##### Bug fixes

* Only fall back to older endpoints on HTTP 404's



  Make the client only fall back to older endpoints on HTTP 404 error codes when
  polling the `deployments/next` endpoint.

  Previous functionality fell back to older endpoints on all error codes. This in
  turn meant that when the client got rate-limited by the server on 429's, the
  client fell back to the older endpoints.

  The problem with this is that only the POSTv2 endpoint supports control maps, so
  when an update with control maps was in progress, the other endpoints would
  return 204, and the client would think the deployment was aborted from the server.
  ([MEN-5421](https://northerntech.atlassian.net/browse/MEN-5421))
* Fixed an issue in which long-running systems, with a long time
  between reboots, and multiple updates encountered the `Tried maximum amount of
  times` error, due to an error in the retry logic.
* Log the fallback to the `artifact_info` file at log level Warn, when
  the Artifact name can not be retrieved from the database.
* add an After systemd dependency on mender-client-data-dir
* The `mender-client.service` file now has an explicit `After`
  dependency on the `data.mount` target, to make sure it is mounted, before the
  client commences operation.
* Fix Git error when installing after the fix for the
  [CVE-2022-24765 Git
  vulnerability](https://nvd.nist.gov/vuln/detail/CVE-2022-24765)
  ([Github's description of the
  issue](https://github.blog/2022-04-12-git-security-vulnerability-announced/)).
  This also fixes a subtle "pseudo abort" issue which can occur in the
  Yocto build environment.
* the HTTP proxy must bind on localhost, not on all the interfaces
  ([MEN-5642](https://northerntech.atlassian.net/browse/MEN-5642))
* Don't accumulate zombies when command output parsing fails.
  ([MEN-5587](https://northerntech.atlassian.net/browse/MEN-5587))
* Only capture module stdout when requested
  ([MEN-5098](https://northerntech.atlassian.net/browse/MEN-5098))
* Fix printing of update module stdout in real-time

##### Features

* Allow to disable HTTP Keep-Alive from config, set idle timeout.
* Inventory push retries and backoff.

  We use RetryPollIntervalSeconds in inventory with the exponential
  backoff via GetExponentialBackoffTime together with a new setting:
  * RetryPollCount -- the max number of tries
  * inventory by default tries 3 times with one minute intervals
    (GetExponentialBackoffTime defaults)
* RetryPollCount applies to all places where backoff is present

##### Other

* Add alternate EFI path to mender-inventory-bootloader-integration
* Add alternate EFI path to mender-inventory-bootloader-inte…
* Add support for the `GET /v2/deployments/device/deployments/{id}/update_control_map` endpoint.
  ([MEN-5542](https://northerntech.atlassian.net/browse/MEN-5542))

##### Dependabot bumps

* Aggregated Dependabot Changelogs:
  * Bumps [github.com/stretchr/testify](https://github.com/stretchr/testify) from 1.7.0 to 1.7.1.
      - [Release notes](https://github.com/stretchr/testify/releases)
      - [Commits](https://github.com/stretchr/testify/compare/v1.7.0...v1.7.1)

      ```
      updated-dependencies:
      - dependency-name: github.com/stretchr/testify
        dependency-type: direct:production
        update-type: version-update:semver-patch
      ```


## mender 3.2.1

_Released 02.02.2022_

### Statistics

A total of 113 lines added, 22 removed (delta 91)

| Developers with the most changesets | |
|---|---|
| Ole Petter Orhagen | 2 (100.0%) |

| Developers with the most changed lines | |
|---|---|
| Ole Petter Orhagen | 115 (100.0%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 2 (100.0%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 115 (100.0%) |

| Employers with the most hackers (total 1) | |
|---|---|
| Northern.tech | 1 (100.0%) |

### Changelogs

#### mender (3.2.1)

New changes in mender since 3.2.0:

* fix(client_update): Only fall back to older endpoints on HTTP 404's

  Make the client only fall back to older endpoints on HTTP 404 error codes when
  polling the `deployments/next` endpoint.

  Previous functionality fell back to older endpoints on all error codes. This in
  turn meant that when the client got rate-limited by the server on 429's, the
  client fell back to the older endpoints.

  The problem with this is that only the POSTv2 endpoint supports control maps, so
  when an update with control maps was in progress, the other endpoints would
  return 204, and the client would think the deployment was aborted from the server.
  ([MEN-5421](https://northerntech.atlassian.net/browse/MEN-5421))


## mender 3.2.0

_Released 01.24.2022_

### Statistics

A total of 4572 lines added, 1819 removed (delta 2753)

| Developers with the most changesets | |
|---|---|
| Kristian Amlie | 23 (39.0%) |
| Lluis Campos | 16 (27.1%) |
| Ole Petter Orhagen | 12 (20.3%) |
| Fabio Tranchitella | 4 (6.8%) |
| Zachary T Welch | 1 (1.7%) |
| Jesus | 1 (1.7%) |
| Maciej Tomczuk | 1 (1.7%) |
| Alf-Rune Siqveland | 1 (1.7%) |

| Developers with the most changed lines | |
|---|---|
| Lluis Campos | 2786 (53.9%) |
| Kristian Amlie | 1295 (25.1%) |
| Ole Petter Orhagen | 1035 (20.0%) |
| Fabio Tranchitella | 32 (0.6%) |
| Alf-Rune Siqveland | 9 (0.2%) |
| Jesus | 6 (0.1%) |
| Zachary T Welch | 2 (0.0%) |
| Maciej Tomczuk | 1 (0.0%) |

| Developers with the most lines removed | |
|---|---|
| Kristian Amlie | 272 (15.0%) |

| Developers with the most signoffs (total 1) | |
|---|---|
| Lluis Campos | 1 (100.0%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 57 (96.6%) |
| Timesys Corporation | 1 (1.7%) |
| wjaxxx@gmail.com | 1 (1.7%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 5158 (99.8%) |
| wjaxxx@gmail.com | 6 (0.1%) |
| Timesys Corporation | 2 (0.0%) |

| Employers with the most signoffs (total 1) | |
|---|---|
| Northern.tech | 1 (100.0%) |

| Employers with the most hackers (total 8) | |
|---|---|
| Northern.tech | 6 (75.0%) |
| wjaxxx@gmail.com | 1 (12.5%) |
| Timesys Corporation | 1 (12.5%) |

### Changelogs

#### mender (3.2.0)

New changes in mender since 3.1.0:

* [FIX] Fetch geo location data once per power cycle
* The client now shows output from scripts executed in the log as regular
  log messages, prefixed by the filedescriptor they are written to, and the script
  executed, like this: 'Output (stdout|stderr) from command \"/usr/bin/foo\": bar.'
  ([MEN-5098](https://northerntech.atlassian.net/browse/MEN-5098))
* Bump github.com/mendersoftware/mender-artifact to 3.6.1
* Fix error not finding active partition for systems where /dev/root is a symlink
* installer/bootenv: support systemd-boot tools
* Upgrade golang.org/x/crypto to the latest version
* Title if the update module has not already requested a reboot. This
  is done, in the case that ArtifactInstall never finished, and hence the reboot
  information from the update module is never collected.
  ([MEN-4882](https://northerntech.atlassian.net/browse/MEN-4882))
* Upgrade from deprecated `golang.org/x/crypto/ssh/terminal` to
  `golang.org/x/term`
  ([QA-235](https://northerntech.atlassian.net/browse/QA-235))
* Mender starts a local HTTP server that will proxy incoming
  requests to `/api/devices` to the currently authenticated Mender server.
  The existing D-Bus API endpoints GetJwtToken and JwtTokenStateChange
  will now return the local address together with the JWT token. Supports
  also websocket upgrade when calling
  `/api/devices/v1/deviceconnect/connect` endpoint
  ([MEN-5216](https://northerntech.atlassian.net/browse/MEN-5216))
* mender setup: Deprecate `--demo` flag and split its
  functionality across new flags `--demo-server` to configure the device
  for a Mender demo server and `--demo-polling` to use demo polling
  intervals. ([MEN-5138](https://northerntech.atlassian.net/browse/MEN-5138))
* Client will no longer cache the Authorization token from
  the server across restarts, meaning that it is no longer possible to
  end up in the situation where a rootfs update with invalid
  authorization data succeeds, only to fail authorization later on when
  the token expires.
  ([MEN-5217](https://northerntech.atlassian.net/browse/MEN-5217))
* It is no longer possible to change the identity of a device
  with a rootfs update. This was not supported before either, but worked
  in a hacky way by abusing the authorization token to get a rootfs
  update with new identity data to succeed. Afterwards the device would
  show up as a new device when the token expired.
  ([MEN-5217](https://northerntech.atlassian.net/browse/MEN-5217))
* ubi: Get rid of useless warning: `Could not resolve path link: ubi..`
* Refresh update control maps before failing an update

  Fix the issue where if a state takes longer than the expiration time
  for the enabled update control map, then by the time the client checks its
  control maps, the map is expired, and the update fails.

  Now the client refreshes the update maps from the server before each pause, and
  hence, this issue will be avoided.
  ([MEN-5096](https://northerntech.atlassian.net/browse/MEN-5096))
* Handle the possibility of losing network connectivity when refreshing
  the update control maps.
* Fix a race condition which can happen during a reboot if
  systemd kills the `reboot` command before it kills the Mender client.
  ([MEN-5340](https://northerntech.atlassian.net/browse/MEN-5340))
* When an update is paused, the client now queries the server
  for updates using the `UpdatePollIntervalSeconds` interval if it is
  shorter than `UpdateControlMapExpirationTimeSeconds`, enabling quicker
  response when continuing an update.
* Fix a (possible) file descriptor leak.
* vendor: Bump mender-artifact to latest master version


## mender 3.1.1

_Released 02.09.2022_

### Statistics

A total of 430 lines added, 58 removed (delta 372)

| Developers with the most changesets | |
|---|---|
| Kristian Amlie | 7 (41.2%) |
| Ole Petter | 6 (35.3%) |
| Lluis Campos | 3 (17.6%) |
| Jesus | 1 (5.9%) |

| Developers with the most changed lines | |
|---|---|
| Ole Petter | 259 (60.1%) |
| Kristian Amlie | 151 (35.0%) |
| Lluis Campos | 15 (3.5%) |
| Jesus | 6 (1.4%) |

| Developers with the most signoffs (total 1) | |
|---|---|
| Ole Petter | 1 (100.0%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 16 (94.1%) |
| wjaxxx@gmail.com | 1 (5.9%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 425 (98.6%) |
| wjaxxx@gmail.com | 6 (1.4%) |

| Employers with the most signoffs (total 1) | |
|---|---|
| Northern.tech | 1 (100.0%) |

| Employers with the most hackers (total 4) | |
|---|---|
| Northern.tech | 3 (75.0%) |
| wjaxxx@gmail.com | 1 (25.0%) |

### Changelogs

#### mender (3.1.1)

New changes in mender since 3.1.0:

* Fix error not finding active partition for systems where /dev/root is a symlink
* Title if the update module has not already requested a reboot. This
  is done, in the case that ArtifactInstall never finished, and hence the reboot
  information from the update module is never collected.
  ([MEN-4882](https://northerntech.atlassian.net/browse/MEN-4882))
* Refresh update control maps before failing an update
  Fix the issue where if a state takes longer than the expiration time
  for the enabled update control map, then by the time the client checks its
  control maps, the map is expired, and the update fails.
  Now the client refreshes the update maps from the server before each pause, and
  hence, this issue will be avoided.
  ([MEN-5096](https://northerntech.atlassian.net/browse/MEN-5096))
* Handle the possibility of losing network connectivity when refreshing
  the update control maps.
* Fix a race condition which can happen during a reboot if
  systemd kills the `reboot` command before it kills the Mender client.
  ([MEN-5340](https://northerntech.atlassian.net/browse/MEN-5340))
* Fix a (possible) file descriptor leak.
* Bump github.com/mendersoftware/mender-artifact to 3.6.x


## mender 3.1.0

_Released 09.28.2021_

### Statistics

A total of 588 lines added, 396 removed (delta 192)

| Developers with the most changesets | |
|---|---|
| Kristian Amlie | 11 (36.7%) |
| Lluis Campos | 5 (16.7%) |
| Alf-Rune Siqveland | 3 (10.0%) |
| Ole Petter Orhagen | 3 (10.0%) |
| Fabio Tranchitella | 2 (6.7%) |
| Uri Ishon | 2 (6.7%) |
| Prashanth Joseph Babu | 2 (6.7%) |
| Alan Martinovic | 1 (3.3%) |
| Manuel Zedel | 1 (3.3%) |

| Developers with the most changed lines | |
|---|---|
| Kristian Amlie | 414 (58.5%) |
| Ole Petter Orhagen | 117 (16.5%) |
| Lluis Campos | 58 (8.2%) |
| Prashanth Joseph Babu | 46 (6.5%) |
| Uri Ishon | 31 (4.4%) |
| Alf-Rune Siqveland | 24 (3.4%) |
| Alan Martinovic | 13 (1.8%) |
| Fabio Tranchitella | 4 (0.6%) |
| Manuel Zedel | 1 (0.1%) |

| Developers with the most lines removed | |
|---|---|
| Lluis Campos | 32 (8.1%) |

| Developers with the most signoffs (total 1) | |
|---|---|
| Kristian Amlie | 1 (100.0%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 26 (86.7%) |
| Complete Solution Robotics, LLC | 2 (6.7%) |
| prashanthjbabu@gmail.com | 2 (6.7%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 631 (89.1%) |
| prashanthjbabu@gmail.com | 46 (6.5%) |
| Complete Solution Robotics, LLC | 31 (4.4%) |

| Employers with the most signoffs (total 1) | |
|---|---|
| Northern.tech | 1 (100.0%) |

| Employers with the most hackers (total 9) | |
|---|---|
| Northern.tech | 7 (77.8%) |
| prashanthjbabu@gmail.com | 1 (11.1%) |
| Complete Solution Robotics, LLC | 1 (11.1%) |

### Changelogs

#### mender (3.1.0)

New changes in mender since 3.0.0:

* Fix a bug which could sometimes lead the client to do a
  rollback after it had already committed. This could happen if the
  client happened to spontaneously reboot or fail during the status
  update to the server. Doing this is not correct according to the state
  flow, and can have unexpected consequences depending on the
  combination of Update Modules and State Scripts.
  ([MEN-4830](https://northerntech.atlassian.net/browse/MEN-4830))
* mender-inventory-network: Fix incompatibility with busybox,
  by using short command line options in grep command.
  ([MEN-4851](https://northerntech.atlassian.net/browse/MEN-4851))
* Do not put useless and sometimes even incorrect zero values
  in the configuration file when running `mender setup`.
  ([MEN-4857](https://northerntech.atlassian.net/browse/MEN-4857))
* Extend logs for docker module
* Add artifact_name to device provides if not found in store
* Support passing docker run CLI arguments when deploying
  an artifact using the `docker` _update module_.
* Implement support for non-U-Boot tool names.
  The tools still have to be command line compatible with the U-Boot
  tools (either u-boot-fw-utils or libubootenv), but the names can be
  different. This allows having U-Boot tools installed alongside
  grub-mender-grubenv tools, whose new names are
  `grub-mender-grubenv-set` and `grub-mender-grubenv-print`, instead of
  `fw_setenv` and `fw_printenv`.
  The two new configuration settings `BootUtilitiesSetActivePart` and
  `BootUtilitiesGetNextActivePart` have been introduced to configure the
  names. If no names are set, then the default is to try the
  grub-mender-grubenv tools first, followed by the "fw_" tools if the
  former are not found.
  ([MEN-3978](https://northerntech.atlassian.net/browse/MEN-3978))
* Add missing filesystem sync which could produce an empty or
  corrupted Update Module file tree in
  `/var/lib/mender/modules/v3/payloads/0000/tree/files/` after an
  unexpected reboot.
* If the mender.conf file has a new server URL or tenant token, the
  client will now remove the cached authorization token upon the next restart of
  the dameon, and hence respect the new configuration, as opposed to letting it
  expire, which was the old functionality.
  ([MEN-3420](https://northerntech.atlassian.net/browse/MEN-3420))
* [FIX] Fetch geo location data once per power cycle


## mender 3.0.2

_Released 02.09.2022_

### Statistics

A total of 430 lines added, 58 removed (delta 372)

| Developers with the most changesets | |
|---|---|
| Kristian Amlie | 7 (41.2%) |
| Ole Petter | 6 (35.3%) |
| Lluis Campos | 3 (17.6%) |
| Jesus | 1 (5.9%) |

| Developers with the most changed lines | |
|---|---|
| Ole Petter | 259 (60.1%) |
| Kristian Amlie | 151 (35.0%) |
| Lluis Campos | 15 (3.5%) |
| Jesus | 6 (1.4%) |

| Developers with the most signoffs (total 1) | |
|---|---|
| Ole Petter | 1 (100.0%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 16 (94.1%) |
| wjaxxx@gmail.com | 1 (5.9%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 425 (98.6%) |
| wjaxxx@gmail.com | 6 (1.4%) |

| Employers with the most signoffs (total 1) | |
|---|---|
| Northern.tech | 1 (100.0%) |

| Employers with the most hackers (total 4) | |
|---|---|
| Northern.tech | 3 (75.0%) |
| wjaxxx@gmail.com | 1 (25.0%) |

#### mender (3.0.2)

### Changelogs

New changes in mender since 3.0.1:

* Fix error not finding active partition for systems where /dev/root is a symlink
* Title if the update module has not already requested a reboot. This
  is done, in the case that ArtifactInstall never finished, and hence the reboot
  information from the update module is never collected.
  ([MEN-4882](https://northerntech.atlassian.net/browse/MEN-4882))
* Refresh update control maps before failing an update
  Fix the issue where if a state takes longer than the expiration time
  for the enabled update control map, then by the time the client checks its
  control maps, the map is expired, and the update fails.
  Now the client refreshes the update maps from the server before each pause, and
  hence, this issue will be avoided.
  ([MEN-5096](https://northerntech.atlassian.net/browse/MEN-5096))
* Handle the possibility of losing network connectivity when refreshing
  the update control maps.
* Fix a race condition which can happen during a reboot if
  systemd kills the `reboot` command before it kills the Mender client.
  ([MEN-5340](https://northerntech.atlassian.net/browse/MEN-5340))
* Fix a (possible) file descriptor leak.
* Bump github.com/mendersoftware/mender-artifact to 3.6.x


## mender 3.0.1

_Released 09.29.2021_

### Statistics

A total of 94 lines added, 48 removed (delta 46)

| Developers with the most changesets | |
|---|---|
| Kristian Amlie | 4 (50.0%) |
| Prashanth Joseph Babu | 2 (25.0%) |
| Alf-Rune Siqveland | 1 (12.5%) |
| Lluis Campos | 1 (12.5%) |

| Developers with the most changed lines | |
|---|---|
| Prashanth Joseph Babu | 46 (48.9%) |
| Kristian Amlie | 31 (33.0%) |
| Alf-Rune Siqveland | 9 (9.6%) |
| Lluis Campos | 8 (8.5%) |

| Developers with the most signoffs (total 1) | |
|---|---|
| Kristian Amlie | 1 (100.0%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 6 (75.0%) |
| prashanthjbabu@gmail.com | 2 (25.0%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 48 (51.1%) |
| prashanthjbabu@gmail.com | 46 (48.9%) |

| Employers with the most signoffs (total 1) | |
|---|---|
| Northern.tech | 1 (100.0%) |

| Employers with the most hackers (total 4) | |
|---|---|
| Northern.tech | 3 (75.0%) |
| prashanthjbabu@gmail.com | 1 (25.0%) |


### Changelogs

#### mender (3.0.1)

New changes in mender since 3.0.0:

* Add artifact_name to device provides if not found in store
* Add missing filesystem sync which could produce an empty or
  corrupted Update Module file tree in
  `/var/lib/mender/modules/v3/payloads/0000/tree/files/` after an
  unexpected reboot.
* [FIX] Fetch geo location data once per power cycle


## mender 3.0.0

_Released 07.14.2021_

### Statistics

A total of 7715 lines added, 3584 removed (delta 4131)

| Developers with the most changesets | |
|---|---|
| Kristian Amlie | 51 (48.6%) |
| Ole Petter Orhagen | 22 (21.0%) |
| Lluis Campos | 19 (18.1%) |
| Alf-Rune Siqveland | 3 (2.9%) |
| Fabio Tranchitella | 3 (2.9%) |
| Manuel Zedel | 2 (1.9%) |
| Nils Olav Kvelvane Johansen | 2 (1.9%) |
| Prashanth Joseph Babu | 2 (1.9%) |
| Grant Sloman | 1 (1.0%) |

| Developers with the most changed lines | |
|---|---|
| Ole Petter Orhagen | 4160 (51.9%) |
| Kristian Amlie | 2479 (30.9%) |
| Lluis Campos | 1175 (14.7%) |
| Alf-Rune Siqveland | 80 (1.0%) |
| Nils Olav Kvelvane Johansen | 43 (0.5%) |
| Manuel Zedel | 35 (0.4%) |
| Prashanth Joseph Babu | 25 (0.3%) |
| Fabio Tranchitella | 22 (0.3%) |
| Grant Sloman | 1 (0.0%) |

| Developers with the most signoffs (total 4) | |
|---|---|
| Ole Petter Orhagen | 3 (75.0%) |
| Lluis Campos | 1 (25.0%) |

| Developers with the most report credits (total 1) | |
|---|---|
| Alex Stout | 1 (100.0%) |

| Developers who gave the most report credits (total 1) | |
|---|---|
| Kristian Amlie | 1 (100.0%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 102 (97.1%) |
| prashanthjbabu@gmail.com | 2 (1.9%) |
| Violet Ultra Ltd | 1 (1.0%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 7994 (99.7%) |
| prashanthjbabu@gmail.com | 25 (0.3%) |
| Violet Ultra Ltd | 1 (0.0%) |

| Employers with the most signoffs (total 4) | |
|---|---|
| Northern.tech | 4 (100.0%) |

| Employers with the most hackers (total 9) | |
|---|---|
| Northern.tech | 7 (77.8%) |
| prashanthjbabu@gmail.com | 1 (11.1%) |
| Violet Ultra Ltd | 1 (11.1%) |

### Changelogs

#### mender (3.0.0)

New changes in mender since 2.6.0:

* mender setup: when configuring for demo using self-signed
  certificate, install the certificate in the local trust store so that
  all components in the system (namely, Mender addons) can trust the
  Mender server without extra configuration.
  ([MEN-4580](https://northerntech.atlassian.net/browse/MEN-4580))
* Warn in the log when the system certificates contain the demo cert.
* Dont Verify SSL if skip verify is set
  If skip verify is set , then we shouldnt call VerifyResult
* Fix infinite carriage return output when running in ADB shell
* Add a DBus endpoint for the UpdateControlMap, which allows
  a user to set the `ID` and `Priority` of a given update process.
  ([MEN-4535](https://northerntech.atlassian.net/browse/MEN-4535))
* The daemon will no longer crash if mender check-update or send-inventory is used before the daemon has finished its set up.
  ([MEN-4074](https://northerntech.atlassian.net/browse/MEN-4074))
* Update Modules Artifact generators: correct --software-version flag
* single-file-artifact-gen: Support concurrent executions
* single-file Update Module: fix rollback functionality
* Add UpdateControlMapBootExpirationTimeSeconds to mender.conf.
* The location of the device type file is now determined by the mender.conf file. If the device type file is not used in mender.conf, the device type file is determined by the --data flag and if the flag is not used, the device type file is set to default. In addition, the scripts and modules directories location is consistent with the --data flag now.
  ([MEN-4669](https://northerntech.atlassian.net/browse/MEN-4669))
* Implement the continue/pause/fail state machine logic
  This adds support for the explit control of the Mender state machine through the
  update control maps functionality.
  The state machine can be controlled through the verbs, puase/continue/fail in
  the states:
  * ArtifactInstall_Enter
  * ArtifactCommit_Enter
  * ArtifactReboot_Enter
  ([MEN-4549](https://northerntech.atlassian.net/browse/MEN-4549))
* Fix D-Bus timeout on errors by finishing handling
  ([MEN-4703](https://northerntech.atlassian.net/browse/MEN-4703))
* Report to deployments/status when pausing in any state
  ([MEN-4624](https://northerntech.atlassian.net/browse/MEN-4624))
* Fix race condition in menderAuthManagerService due to
  concurrent map access. This could manifest either as a crash, or as a
  failure to deliver the JwtToken to dependent processes, such as
  mender-connect.
* Fix race condition in `dbus.RegisterMethodCallCallback` due
  to concurrent map access. This could manifest either as a crash, or as
  a failure to deliver the JwtToken to dependent processes, such as
  mender-connect.
* Fix: Correctly log the error response message from server errors
* Fix occasional crash when exiting using SIGTERM.
* Fix: `mender-client.service` and the old `mender.service`
  services can no longer run at the same time. If anyone has both, then
  `mender.service` should be removed from the system.
* Previously the Mender client would hide output from the
  child processes it ran, leading to errors from tools such as
  `fw_printenv`, not showing up in the logs.
  Now default to showing all output from the child processes called in
  the client logs.
* The client now supports the HTTP Device API v2.
  ([MEN-4785](https://northerntech.atlassian.net/browse/MEN-4785))
* Mark deployment as failed on bad signature instead of retrying.
* CLI commands prefixed with hyphen are now deprecated, use
  instead directly the command name. For example `mender daemon`, `mender
  commit`, `mender show-artifact`, etc.
  ([MEN-4808](https://northerntech.atlassian.net/browse/MEN-4808))
* Remove deprecated flag --log-modules
  ([MEN-4808](https://northerntech.atlassian.net/browse/MEN-4808))
* Fix a bug which could sometimes lead the client to do a
  rollback after it had already committed. This could happen if the
  client happened to spontaneously reboot or fail during the status
  update to the server. Doing this is not correct according to the state
  flow, and can have unexpected consequences depending on the
  combination of Update Modules and State Scripts.
  ([MEN-4830](https://northerntech.atlassian.net/browse/MEN-4830))
* mender-inventory-network: Fix incompatibility with busybox,
  by using short command line options in grep command.
  ([MEN-4851](https://northerntech.atlassian.net/browse/MEN-4851))
* Do not put useless and sometimes even incorrect zero values
  in the configuration file when running `mender setup`.
  ([MEN-4857](https://northerntech.atlassian.net/browse/MEN-4857))

## mender 2.6.1

_Released 07.14.2021_

### Statistics

A total of 506 lines added, 215 removed (delta 291)

| Developers with the most changesets | |
|---|---|
| Lluis Campos | 6 (37.5%) |
| Kristian Amlie | 5 (31.2%) |
| Ole Petter Orhagen | 2 (12.5%) |
| Nils Olav Kvelvane Johansen | 2 (12.5%) |
| Prashanth Joseph Babu | 1 (6.2%) |

| Developers with the most changed lines | |
|---|---|
| Lluis Campos | 290 (49.9%) |
| Kristian Amlie | 186 (32.0%) |
| Ole Petter Orhagen | 58 (10.0%) |
| Nils Olav Kvelvane Johansen | 44 (7.6%) |
| Prashanth Joseph Babu | 3 (0.5%) |

| Developers with the most lines removed | |
|---|---|
| Kristian Amlie | 47 (21.9%) |

| Developers with the most signoffs (total 2) | |
|---|---|
| Ole Petter Orhagen | 2 (100.0%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 15 (93.8%) |
| prashanthjbabu@gmail.com | 1 (6.2%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 578 (99.5%) |
| prashanthjbabu@gmail.com | 3 (0.5%) |

| Employers with the most signoffs (total 2) | |
|---|---|
| Northern.tech | 2 (100.0%) |

| Employers with the most hackers (total 5) | |
|---|---|
| Northern.tech | 4 (80.0%) |
| prashanthjbabu@gmail.com | 1 (20.0%) |

### Changelogs

#### mender (2.6.1)

New changes in mender since 2.6.0:

* Dont Verify SSL if skip verify is set
  If skip verify is set , then we shouldnt call VerifyResult
* Update Modules Artifact generators: correct --software-version flag
* single-file-artifact-gen: Support concurrent executions
* single-file Update Module: fix rollback functionality
* The daemon will no longer crash if mender check-update or send-inventory is used before the daemon has finished its set up.
  ([MEN-4074](https://northerntech.atlassian.net/browse/MEN-4074))
* Fix D-Bus timeout on errors by finishing handling
  ([MEN-4703](https://northerntech.atlassian.net/browse/MEN-4703))
* The location of the device type file is now determined by the mender.conf file. If the device type file is not used in mender.conf, the device type file is determined by the --data flag and if the flag is not used, the device type file is set to default. In addition, the scripts and modules directories location is consistent with the --data flag now.
  ([MEN-4669](https://northerntech.atlassian.net/browse/MEN-4669))
* Fix race condition in menderAuthManagerService due to
  concurrent map access. This could manifest either as a crash, or as a
  failure to deliver the JwtToken to dependent processes, such as
  mender-connect.
* Fix race condition in `dbus.RegisterMethodCallCallback` due
  to concurrent map access. This could manifest either as a crash, or as
  a failure to deliver the JwtToken to dependent processes, such as
  mender-connect.
* Fix occasional crash when exiting using SIGTERM.
* Fix: Correctly log the error response message from server errors
* Fix a bug which could sometimes lead the client to do a
  rollback after it had already committed. This could happen if the
  client happened to spontaneously reboot or fail during the status
  update to the server. Doing this is not correct according to the state
  flow, and can have unexpected consequences depending on the
  combination of Update Modules and State Scripts.
  ([MEN-4830](https://northerntech.atlassian.net/browse/MEN-4830))
* mender-inventory-network: Fix incompatibility with busybox,
  by using short command line options in grep command.
  ([MEN-4851](https://northerntech.atlassian.net/browse/MEN-4851))

## mender 2.6.0

_Released 04.16.2021_

### Changelogs

#### mender (2.6.0)

New changes in mender since 2.5.0:

* fix, support white spaces in single-file artifacts' names
([MEN-4179](https://northerntech.atlassian.net/browse/MEN-4179))
* Change provider in inventory-geo script to ipinfo.io
* Cache geo-location inventory data in volatile memory
* Log which scripts are run at the info level
* Filter out docker network interfaces in inventory
This adds functionality for filtering out interfaces matching
* br-.*
* veth.*
* docker.*
by default, so that docker network interfaces do not flood the inventory on
hosts running a lot of docker containers.
If re-adding this functionality is required, set the environment variable:
* INCLUDE_DOCKER_INTERFACES=true
([MEN-4487](https://northerntech.atlassian.net/browse/MEN-4487))
* single-file: Use atomic file operations.
* single-file: Use stderr for all error messages.
* Remove deprecated field HttpsClient from config file (gets
the rid of bogus SSL warnings on `mender show-artifact` and any other
cli operation).
([MEN-4398](https://northerntech.atlassian.net/browse/MEN-4398))
* Send the inventory after a successful deployment, even though the
device has not rebooted.
([MEN-4518](https://northerntech.atlassian.net/browse/MEN-4518))
* mender setup: when configuring for demo using self-signed
certificate, install the certificate in the local trust store so that
all components in the system (namely, Mender addons) can trust the
Mender server without extra configuration.
([MEN-4580](https://northerntech.atlassian.net/browse/MEN-4580))
* Warn in the log when the system certificates contain the demo cert.
* Aggregated Dependabot Changelogs:
* Bumps [github.com/stretchr/testify](https://github.com/stretchr/testify) from 1.6.1 to 1.7.0.
- [Release notes](https://github.com/stretchr/testify/releases)
- [Commits](https://github.com/stretchr/testify/compare/v1.6.1...v1.7.0)


## mender 2.5.4

_Released 02.09.2022_

### Statistics

A total of 297 lines added, 52 removed (delta 245)

| Developers with the most changesets | |
|---|---|
| Kristian Amlie | 7 (53.8%) |
| Lluis Campos | 3 (23.1%) |
| Ole Petter | 2 (15.4%) |
| Jesus | 1 (7.7%) |

| Developers with the most changed lines | |
|---|---|
| Kristian Amlie | 152 (49.8%) |
| Ole Petter | 125 (41.0%) |
| Lluis Campos | 22 (7.2%) |
| Jesus | 6 (2.0%) |

| Developers with the most signoffs (total 2) | |
|---|---|
| Lluis Campos | 1 (50.0%) |
| Ole Petter | 1 (50.0%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 12 (92.3%) |
| wjaxxx@gmail.com | 1 (7.7%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 299 (98.0%) |
| wjaxxx@gmail.com | 6 (2.0%) |

| Employers with the most signoffs (total 2) | |
|---|---|
| Northern.tech | 2 (100.0%) |

| Employers with the most hackers (total 4) | |
|---|---|
| Northern.tech | 3 (75.0%) |
| wjaxxx@gmail.com | 1 (25.0%) |

### Changelogs

#### mender (2.5.4)

New changes in mender since 2.5.3:

* Fix error not finding active partition for systems where /dev/root is a symlink
* Title if the update module has not already requested a reboot. This
  is done, in the case that ArtifactInstall never finished, and hence the reboot
  information from the update module is never collected.
  ([MEN-4882](https://northerntech.atlassian.net/browse/MEN-4882))
* Fix a race condition which can happen during a reboot if
  systemd kills the `reboot` command before it kills the Mender client.
  ([MEN-5340](https://northerntech.atlassian.net/browse/MEN-5340))
* Fix a (possible) file descriptor leak.
* Bump github.com/mendersoftware/mender-artifact to 3.5.x


## mender 2.5.3

_Release date 09.29.2021_

### Statistics

A total of 97 lines added, 51 removed (delta 46)

| Developers with the most changesets | |
|---|---|
| Kristian Amlie | 5 (55.6%) |
| Prashanth Joseph Babu | 2 (22.2%) |
| Alf-Rune Siqveland | 1 (11.1%) |
| Lluis Campos | 1 (11.1%) |

| Developers with the most changed lines | |
|---|---|
| Prashanth Joseph Babu | 46 (47.4%) |
| Kristian Amlie | 34 (35.1%) |
| Alf-Rune Siqveland | 9 (9.3%) |
| Lluis Campos | 8 (8.2%) |

| Developers with the most signoffs (total 1) | |
|---|---|
| Kristian Amlie | 1 (100.0%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 7 (77.8%) |
| prashanthjbabu@gmail.com | 2 (22.2%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 51 (52.6%) |
| prashanthjbabu@gmail.com | 46 (47.4%) |

| Employers with the most signoffs (total 1) | |
|---|---|
| Northern.tech | 1 (100.0%) |

| Employers with the most hackers (total 4) | |
|---|---|
| Northern.tech | 3 (75.0%) |
| prashanthjbabu@gmail.com | 1 (25.0%) |

### Changelogs

#### mender (2.5.3)

New changes in mender since 2.5.2:

* Add artifact_name to device provides if not found in store
* Add missing filesystem sync which could produce an empty or
  corrupted Update Module file tree in
  `/var/lib/mender/modules/v3/payloads/0000/tree/files/` after an
  unexpected reboot.
* [FIX] Fetch geo location data once per power cycle


## mender 2.5.2

_Released 07.14.2021_

### Statistics

A total of 506 lines added, 215 removed (delta 291)

| Developers with the most changesets | |
|---|---|
| Kristian Amlie | 5 (33.3%) |
| Lluis Campos | 5 (33.3%) |
| Ole Petter Orhagen | 2 (13.3%) |
| Nils Olav Kvelvane Johansen | 2 (13.3%) |
| Prashanth Joseph Babu | 1 (6.7%) |

| Developers with the most changed lines | |
|---|---|
| Lluis Campos | 289 (49.7%) |
| Kristian Amlie | 186 (32.0%) |
| Ole Petter Orhagen | 58 (10.0%) |
| Nils Olav Kvelvane Johansen | 45 (7.7%) |
| Prashanth Joseph Babu | 3 (0.5%) |

| Developers with the most lines removed | |
|---|---|
| Kristian Amlie | 47 (21.9%) |

| Developers with the most signoffs (total 2) | |
|---|---|
| Ole Petter Orhagen | 2 (100.0%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 14 (93.3%) |
| prashanthjbabu@gmail.com | 1 (6.7%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 578 (99.5%) |
| prashanthjbabu@gmail.com | 3 (0.5%) |

| Employers with the most signoffs (total 2) | |
|---|---|
| Northern.tech | 2 (100.0%) |

| Employers with the most hackers (total 5) | |
|---|---|
| Northern.tech | 4 (80.0%) |
| prashanthjbabu@gmail.com | 1 (20.0%) |

### Changelogs

#### mender (2.5.2)

New changes in mender since 2.5.1:

* Dont Verify SSL if skip verify is set
  If skip verify is set , then we shouldnt call VerifyResult
* Update Modules Artifact generators: correct --software-version flag
* single-file-artifact-gen: Support concurrent executions
* single-file Update Module: fix rollback functionality
* The daemon will no longer crash if mender check-update or send-inventory is used before the daemon has finished its set up.
  ([MEN-4074](https://northerntech.atlassian.net/browse/MEN-4074))
* Fix D-Bus timeout on errors by finishing handling
  ([MEN-4703](https://northerntech.atlassian.net/browse/MEN-4703))
* The location of the device type file is now determined by the mender.conf file. If the device type file is not used in mender.conf, the device type file is determined by the --data flag and if the flag is not used, the device type file is set to default. In addition, the scripts and modules directories location is consistent with the --data flag now.
  ([MEN-4669](https://northerntech.atlassian.net/browse/MEN-4669))
* Fix race condition in menderAuthManagerService due to
  concurrent map access. This could manifest either as a crash, or as a
  failure to deliver the JwtToken to dependent processes, such as
  mender-connect.
* Fix race condition in `dbus.RegisterMethodCallCallback` due
  to concurrent map access. This could manifest either as a crash, or as
  a failure to deliver the JwtToken to dependent processes, such as
  mender-connect.
* Fix occasional crash when exiting using SIGTERM.
* Fix: Correctly log the error response message from server errors
* Fix a bug which could sometimes lead the client to do a
  rollback after it had already committed. This could happen if the
  client happened to spontaneously reboot or fail during the status
  update to the server. Doing this is not correct according to the state
  flow, and can have unexpected consequences depending on the
  combination of Update Modules and State Scripts.
  ([MEN-4830](https://northerntech.atlassian.net/browse/MEN-4830))

## mender 2.5.1

_Released 16.04.2021_

### Changelogs

#### mender (2.5.1)

New changes in mender since 2.5.0:

* Change provider in inventory-geo script to ipinfo.io
* Cache geo-location inventory data in volatile memory
* Remove deprecated field HttpsClient from config file (gets
the rid of bogus SSL warnings on `mender show-artifact` and any other
cli operation).
([MEN-4398](https://northerntech.atlassian.net/browse/MEN-4398))
* single-file: Use atomic file operations.
* single-file: Use stderr for all error messages.
* Send the inventory after a successful deployment, even though the
device has not rebooted.
([MEN-4518](https://northerntech.atlassian.net/browse/MEN-4518))

## mender 2.5.0

_Released 01.20.2021_

### Changelogs

#### mender (2.5.0)

New changes in mender since 2.4.0:

* Fix rootfs-image-v2 commit in standalone mode when upgrade fails
* Add --reboot-exit-code parameter to "install" command.
* Fixed wrong error produced by rootfs-image commit
* Gracefully shutdown on SIGTERM
* implement "show-provides" command on client
([MEN-3074](https://northerntech.atlassian.net/browse/MEN-3074))
* add inventory script to list the artifact provides data
([MEN-3073](https://northerntech.atlassian.net/browse/MEN-3073))
* add support for software version flags in artifact generators
([MEN-3481](https://northerntech.atlassian.net/browse/MEN-3481))
* Support for `clears_artifact_provides` field in Artifacts.
([MEN-3075](https://northerntech.atlassian.net/browse/MEN-3075))
* switch to the new PUT endpoint to update inventory attributes
([MEN-4001](https://northerntech.atlassian.net/browse/MEN-4001))
* Add Glib's GIO dependency for D-Bus interface. It can be
opt-out using `nodbus` at compile time.
([MEN-4032](https://northerntech.atlassian.net/browse/MEN-4032))
* Add support for probing the U-Boot environment separator
([MEN-3970](https://northerntech.atlassian.net/browse/MEN-3970))
* Allow to load private key from the Security configuration section
([MEN-3924](https://northerntech.atlassian.net/browse/MEN-3924))
* artifact-gen: Improve error message when mender-artifact is not found.
([MEN-4044](https://northerntech.atlassian.net/browse/MEN-4044))
* Fix: Do not switch boot partitions on installation errors on the
active partition.
([MEN-3980](https://northerntech.atlassian.net/browse/MEN-3980))
* Correctly log the error message from the server on failed update
download attempts.
* mender-inventory-geo: Set connection timeout to 10s.
* Decrease the verbosity of 'Authorization requests failed' errors in
the log output.
* service API to register object interfaces over System DBus
([MEN-4009](https://northerntech.atlassian.net/browse/MEN-4009))
* Add DBus support to AuthManager implementing WithDBus
* implement DBus signal ValidJwtTokenAvailable
([MEN-4017](https://northerntech.atlassian.net/browse/MEN-4017))
* Add an inventory script for reporting the update-modules currently
installed on a device.
* Add busconfig file for DBus API to install steps.
([MEN-4030](https://northerntech.atlassian.net/browse/MEN-4030))
* Replace the current progressbar with a minimalistic and less verbose implementation.
* The 'inventory-geo-script' now has a separate install target:
'install-inventory-network-scripts'. Note however that it is still installed by
the default 'install-inventory-scripts' target.
* When available, enable D-Bus interface by default
* Exit with code 0 on a received SIGTERM signal.
([MEN-4170](https://northerntech.atlassian.net/browse/MEN-4170))
* Add passphrase-file global option.
* Fix error parsing response for getting tenant token on setup
([MEN-4245](https://northerntech.atlassian.net/browse/MEN-4245))
* Extend the D-Bus API to return the server URL
([MEN-4360](https://northerntech.atlassian.net/browse/MEN-4360))
* Aggregated Dependabot Changelogs:
* Bumps [github.com/mendersoftware/openssl](https://github.com/mendersoftware/openssl) from 1.0.9 to 1.0.10.
- [Release notes](https://github.com/mendersoftware/openssl/releases)
- [Commits](https://github.com/mendersoftware/openssl/compare/v1.0.9...v1.0.10)
* Bump github.com/mendersoftware/openssl from 1.0.9 to 1.0.10
* Bumps [github.com/mendersoftware/openssl](https://github.com/mendersoftware/openssl) from 1.0.10 to 1.1.0.
- [Release notes](https://github.com/mendersoftware/openssl/releases)
- [Commits](https://github.com/mendersoftware/openssl/compare/v1.0.10...v1.1.0)
* Bump github.com/mendersoftware/openssl from 1.0.10 to 1.1.0

## mender 2.4.2

_Released 01.21.2021_

### Changelogs

#### mender (2.4.2)

New changes in mender since 2.4.0:

* Add support for probing the U-Boot environment separator
([MEN-3970](https://northerntech.atlassian.net/browse/MEN-3970))
* Fix: Do not switch boot partitions on installation errors on the
active partition.
([MEN-3980](https://northerntech.atlassian.net/browse/MEN-3980))
* Allow to load private key from the Security configuration section
([MEN-3924](https://northerntech.atlassian.net/browse/MEN-3924))
* mender-inventory-geo: Set connection timeout to 10s.
* Fix error parsing response for getting tenant token on setup
([MEN-4245](https://northerntech.atlassian.net/browse/MEN-4245))

## mender 2.4.1

_Released 11.03.2020_

### Statistics

A total of 397 lines added, 161 removed (delta 236)

| Developers with the most changesets | |
|---|---|
| Ole Petter Orhagen | 4 (36.4%) |
| Peter Grzybowski | 3 (27.3%) |
| Lluis Campos | 3 (27.3%) |
| Fabio Tranchitella | 1 (9.1%) |

| Developers with the most changed lines | |
|---|---|
| Ole Petter Orhagen | 314 (77.0%) |
| Peter Grzybowski | 51 (12.5%) |
| Lluis Campos | 42 (10.3%) |
| Fabio Tranchitella | 1 (0.2%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 11 (100.0%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 408 (100.0%) |

| Employers with the most hackers (total 4) | |
|---|---|
| Northern.tech | 4 (100.0%) |

### Changelogs

#### mender (2.4.1)

New changes in mender since 2.4.0:

* Add support for probing the U-Boot environment separator
([MEN-3970](https://northerntech.atlassian.net/browse/MEN-3970))
* Fix: Do not switch boot partitions on installation errors on the
active partition.
([MEN-3980](https://northerntech.atlassian.net/browse/MEN-3980))
* Allow to load private key from the Security configuration section
([MEN-3924](https://northerntech.atlassian.net/browse/MEN-3924))

## mender 2.4.0

_Released 09.11.2020_

### Changelogs

#### mender (2.4.0)

New changes in mender since 2.3.0:

* keystore: use openssl bindings
Switch the code that signs the server's authentication request
to use openssl. This allows to use ssl_engines, which permit to
use PKCS#11 or TPMs as keystore.
* vendor: switch openssl bindings to github.com/Linutronix/golang-openssl
spacemonkeygo/openssl depends on spacelog, which increases binary
size by about 2MB due to using reflect.
Switch to a fork which has the logger removed.
This patch can hopefully be reverted someday, when the logger
removal has been mainlined.
* Log state-script stderr as info, not error
([MEN-3316](https://northerntech.atlassian.net/browse/MEN-3316))
* mender-inventory-geo script to return geo localization data
* Add support for libubootenv as boot loader user space tools
provider. ([MEN-3684](https://northerntech.atlassian.net/browse/MEN-3684))
* Remove Server config warn on mender setup command
([MEN-3652](https://northerntech.atlassian.net/browse/MEN-3652))
* Fix broken logging to syslogger.
([MEN-3676](https://northerntech.atlassian.net/browse/MEN-3676))
* chmod 600 on config file
([MEN-3762](https://northerntech.atlassian.net/browse/MEN-3762))
* mender-device-identity: skip dummyX interfaces
* mender.service: update to run after network-online.target
* Switch to OpenSSL for all server communication.
([MEN-3730](https://northerntech.atlassian.net/browse/MEN-3730))
* keystore: support ed25519 keys
* Add the ability to configure the client with a client certificate and
private key in order to enable mTLS in the client communication setup.
([MEN-3115](https://northerntech.atlassian.net/browse/MEN-3115))

## mender 2.3.3

_Released 16.04.2021_

### Changelogs

#### mender (2.3.3)

New changes in mender since 2.3.2:

* single-file: Use atomic file operations.
* single-file: Use stderr for all error messages.
* Send the inventory after a successful deployment, even though the
device has not rebooted.
([MEN-4518](https://northerntech.atlassian.net/browse/MEN-4518))
* fix, support white spaces in single-file artifacts' names
([MEN-4179](https://northerntech.atlassian.net/browse/MEN-4179))

## mender 2.3.2

_Released 01.21.2021_

### Changelogs

#### mender (2.3.2)

New changes in mender since 2.3.0:

* Add support for probing the U-Boot environment separator
([MEN-3970](https://northerntech.atlassian.net/browse/MEN-3970))
* Fix: Do not switch boot partitions on installation errors on the
active partition.
([MEN-3980](https://northerntech.atlassian.net/browse/MEN-3980))
* Fix error parsing response for getting tenant token on setup
([MEN-4245](https://northerntech.atlassian.net/browse/MEN-4245))

## mender 2.3.1

_Released 11.03.2020_

### Statistics

A total of 211 lines added, 26 removed (delta 185)

| Developers with the most changesets | |
|---|---|
| Ole Petter Orhagen | 5 (55.6%) |
| Lluis Campos | 3 (33.3%) |
| Fabio Tranchitella | 1 (11.1%) |

| Developers with the most changed lines | |
|---|---|
| Ole Petter Orhagen | 179 (80.6%) |
| Lluis Campos | 42 (18.9%) |
| Fabio Tranchitella | 1 (0.5%) |

| Top changeset contributors by employer | |
|---|---|
| Northern.tech | 9 (100.0%) |

| Top lines changed by employer | |
|---|---|
| Northern.tech | 222 (100.0%) |

| Employers with the most hackers (total 3) | |
|---|---|
| Northern.tech | 3 (100.0%) |

### Changelogs

#### mender (2.3.1)

New changes in mender since 2.3.0:

* Add support for probing the U-Boot environment separator
([MEN-3970](https://northerntech.atlassian.net/browse/MEN-3970))
* Fix: Do not switch boot partitions on installation errors on the
active partition.
([MEN-3980](https://northerntech.atlassian.net/browse/MEN-3980))

## mender 2.3.0

_Released 07.15.2020_

### Changelogs

#### mender (2.3.0)

New changes in mender since 2.2.0:

* Fix "State transition loop detected" when retrying status update.
* Remove text/template dependency from the cli library reducing
mender client binary size by approximately 20%
* Renamed systemd mender.service -> mender-client.service
([MEN-2948](https://northerntech.atlassian.net/browse/MEN-2948))
* Fixes various logging nitpicks
* Deprecated the log-modules cli commandline flag
([MEN-3251](https://northerntech.atlassian.net/browse/MEN-3251))
* Make the system logger respect the global log level
([MEN-3135](https://northerntech.atlassian.net/browse/MEN-3135))
* Make the system logger write to the LOG_USER facility by default
* Fix Stat_t.Dev/Rdev type assumption
* Send Provides in the deployments API call
([MEN-2587](https://northerntech.atlassian.net/browse/MEN-2587))
* Report function caller on all logs when loglevel=Debug

## mender 2.2.1

_Released 07.15.2020_

### Changelogs

#### mender (2.2.1)

New changes in mender since 2.2.0:

* Fix check-update and send-inventory options on deb install
([MEN-3277](https://northerntech.atlassian.net/browse/MEN-3277))
* Fix Stat_t.Dev/Rdev type assumption
* Log state-script stderr as info, not error
([MEN-3316](https://northerntech.atlassian.net/browse/MEN-3316))
* Fix broken logging to syslogger.
([MEN-3676](https://northerntech.atlassian.net/browse/MEN-3676))
* Add support for libubootenv as boot loader user space tools
provider. ([MEN-3684](https://northerntech.atlassian.net/browse/MEN-3684))
* Make interactive setup device type default to configured device type
([MEN-3777](https://northerntech.atlassian.net/browse/MEN-3777))

## mender 2.2.0

_Released 03.05.2020_

### Changelogs

#### mender (2.2.0)

New changes in mender since 2.2.0b1:

* Remove text/template dependency from the cli library reducing
mender client binary size by approximately 20%
* Fix "State transition loop detected" when retrying status update.

New changes in mender since 2.1.2:

* mender setup cli command and new CLI package
([MEN-2418](https://northerntech.atlassian.net/browse/MEN-2418), [MEN-2806](https://northerntech.atlassian.net/browse/MEN-2806))
* Fix UBI device size calculation
* store: Save artifact provides for dependency verifications
* app: Verify artifact (version >= 3) dependencies with current artifact
* store/app{standalone}: Artifact dependency checking for artifact v3
* app/store{standalone}: Unit tests Artifact v3 depends and provides
* Enable the usage of the full Mender-Artifact version 3 format
([MEN-2642](https://northerntech.atlassian.net/browse/MEN-2642))
* support: modules-artifact-gen: Fix typo in default name of output file
* Rename --mender-professional flag to --hosted-mender
* Add --quiet flag and remove --run-daemon option and confirm device
* Now the client stores Artifact provides parameters across reboots in
standalone mode. Previously this data was ignored, and hence upgrading with an
Artifact with provides parameters these were lost.
([MEN-2969](https://northerntech.atlassian.net/browse/MEN-2969))
* Set default device type to hostname for interactive setup
* New command: `snapshot dump` to dump current rootfs
* Skip special device "rootfs" when determining rootfs type
* Report 'Unknown' rootfs type if we can't detect it
* Optimize rootfs-update image writes
([MEN-2939](https://northerntech.atlassian.net/browse/MEN-2939))
* Make `single-file-artifact-gen` script POSIX compliant.
([MEN-3049](https://northerntech.atlassian.net/browse/MEN-3049))
* Fix segfault when running `mender setup` on a read-only
filesystem.
* Fix crash when specified certificate can't be opened.
Both the `ServerCertificate` setting and the system certificates are
now optional, in the sense that the client will run without them.
However, the client will not be able to connect without the right
certificates, so the main usecase of this change is to have a workable
client that will roll back if connections can't be made, instead of
exiting. ([MEN-3047](https://northerntech.atlassian.net/browse/MEN-3047))
* Add warning message when server certificate can't be parsed.
* snapshot: Added watchdog timer to keep system from freezing
* snapshot: Add compression options to speed up transfer
* Improved error message when an update-module is missing
([MEN-3007](https://northerntech.atlassian.net/browse/MEN-3007))
* snapshot: New flag `--source` specifying the source
filesystem to snapshot

## mender 2.1.3

_Released 03.05.2020_

### Changelogs

#### mender (2.1.3)

New changes in mender since 2.1.2:

* Fix crash when specified certificate can't be opened.
Both the `ServerCertificate` setting and the system certificates are
now optional, in the sense that the client will run without them.
However, the client will not be able to connect without the right
certificates, so the main usecase of this change is to have a workable
client that will roll back if connections can't be made, instead of
exiting. ([MEN-3047](https://northerntech.atlassian.net/browse/MEN-3047))
* Add warning message when server certificate can't be parsed.


## mender 2.1.2

_Released 12.05.2019_

### Changelogs

#### mender (2.1.2)

New changes in mender since 2.1.1:

* Fix UBI device size calculation

## mender 2.1.1

_Released 10.23.2019_

### Changelogs

#### mender (2.1.1)

New changes in mender since 2.1.0:

* module/single-file: fix rollback state by correctly defining filename
* Check for -f option in stat command
* Set hard limit(10) for client update status report retries
This fixes an issue where the maxSendingAttemps in
updateReportRetry state could be set real high, since it is calculated
as UpdatePollIntervalSeconds / RetryPollIntervalSeconds. This adds a
hard upper limit of 10 retries for the client in any case.
([MEN-2676](https://northerntech.atlassian.net/browse/MEN-2676))

## mender 2.1.2

_Released 12.05.2019_

### Changelogs

#### mender (2.1.2)

New changes in mender since 2.1.0:

* module/single-file: fix rollback state by correctly defining filename
* Check for -f option in stat command
* Set hard limit(10) for client update status report retries
This fixes an issue where the maxSendingAttemps in
updateReportRetry state could be set real high, since it is calculated
as UpdatePollIntervalSeconds / RetryPollIntervalSeconds. This adds a
hard upper limit of 10 retries for the client in any case.
([MEN-2676](https://northerntech.atlassian.net/browse/MEN-2676))
* Fix UBI device size calculation

## mender 2.1.0

_Released 09.16.2019_

### Changelogs

#### mender (2.1.0)

New changes in mender since 2.0.1:

* rootfs-image-v2: Make sure to follow the spec regarding `stream-next`.
We should to read the final empty entry to make sure the client does
not block.
* Restore error code 2 behavior when there is nothing to commit.
* Fix read error masking in installer.chunkedCopy(...) func
* Update vendored dependencies for client.
* When set, HTTP proxy settings in http_proxy/https_proxy environment variables are respected now.
* module-artifact-gen: Fix inability to specify more than one device_type.
* Make all errors checked or explicitly ignored
All possible errors must be checked across all code base.
If an error is intentionally ignored it should be done explicitly.
* add state-scripts example scripts to wait for network connectivity
before trying to connect to the Mender server.
([MEN-2457](https://northerntech.atlassian.net/browse/MEN-2457))
* Artifact gen: Support argument passthrough to `mender-artifact`.
Use `--` to signal that remaining arguments should be passed directly
to `mender-artifact`.
* Make the device type file location configurable
* Make channel receiving user signals buffered
The commit fixes improper usage of signal.Notify(...) func from Go stdlib.
A channel must be buffered to properly receive signals:
https://golang.org/pkg/os/signal/#Notify
Also there is no need to reallocate channel and defer signal.Stop(...)
each time user signal is received. Thus less resources are used.
* standalone: Fix artifact committing not working after upgrading from 1.x.
([MEN-2465](https://northerntech.atlassian.net/browse/MEN-2465))
* Print warning on an invalid server certificate.
([MEN-2378](https://northerntech.atlassian.net/browse/MEN-2378))
* add state-script example to preserve ssh keys accross updates
([MEN-2457](https://northerntech.atlassian.net/browse/MEN-2457))
* Fix `/bin/lsb_release` not being picked up by inventory script.
* Fix misspells in comments and error messages
* Make sure ARM64 is included in bootloader integration inventory.
* Added example to retain systemd network configuration.
* single-file module: Make sure permissions are preserved.
Also make sure that backup preserves permissions.
* add state-script example to utilize dbus to broadcast
Mender states ([MEN-2457](https://northerntech.atlassian.net/browse/MEN-2457))
* Provide command line interface to force inventory update.
([MEN-2131](https://northerntech.atlassian.net/browse/MEN-2131))

## mender 2.0.1

_Released 06.24.2019_

### Changelogs

#### mender (2.0.1)

New changes in mender since 2.0.0:

* module-artifact-gen: Fix inability to specify more than one device_type.
* single-file module: Make sure permissions are preserved.
Also make sure that backup preserves permissions.
* Artifact gen: Support argument passthrough to `mender-artifact`.
Use `--` to signal that remaining arguments should be passed directly
to `mender-artifact`.
* Restore error code 2 behavior when there is nothing to commit.

## mender 2.0.0

_Released 05.07.2019_

### Changelogs

#### mender (2.0.0)

New changes in mender since 2.0.0b1:

* Version files are now allowed to contain a newline character. Also
some minor changes, as readVersion now accepts an io.Reader, and files are
opened outside of the function. This means that the error message is now
consistent for all the uses of readVersion.
([MEN-2318](https://northerntech.atlassian.net/browse/MEN-2318))
* file-install modules: Don't destroy original before we know we have a backup.
* Fix File Install UM to not wipe out dest_dir on single file installs
* standalone: Fix artifact committing not working after upgrading from 1.x.
([MEN-2465](https://northerntech.atlassian.net/browse/MEN-2465))
* Deprecate old file-install Update Module and create instead
two new ones: single-file-install and file-tree-install. These have a
simpler logic and clearer scope. See for details.
([MEN-2442](https://northerntech.atlassian.net/browse/MEN-2442))
* Don't push network interfaces without a mac address to inventory
* Disallow installing file trees on root destination dir for
File Install Update Module
* Make sure ARM64 is included in bootloader integration inventory.
* Mender no longer misidentifies LVM volumes.
([MEN-2302](https://northerntech.atlassian.net/browse/MEN-2302))
* Update modules: Implement `NeedsArtifactReboot` -> `Automatic`.
([MEN-2011](https://northerntech.atlassian.net/browse/MEN-2011))

New changes in mender since 1.7.0:

* Bugfix: State-script error code in Sync-Enter causes infinite loop
([MEN-2195](https://northerntech.atlassian.net/browse/MEN-2195))
* Allow rootfsPartA and rootfsPartB to be symlinks
* Rewrite AuthorizeWaitState to fix an infinite loop bug
([MEN-2195](https://northerntech.atlassian.net/browse/MEN-2195))
* Modify design for exec.Cmd stdout/stderr logging
* Place UM generator scripts in a dedicated folder
([MEN-2371](https://northerntech.atlassian.net/browse/MEN-2371))
* Write Update Module to do file(s) install
([MEN-2371](https://northerntech.atlassian.net/browse/MEN-2371))
* Set StateScriptTimeout default to 1h
([MEN-2409](https://northerntech.atlassian.net/browse/MEN-2409))
* Add source-installation instructions to README.md.
* Add `rootfs-image-v2` as a demonstration of how to
reimplement Mender's `rootfs-image` update type as an update module.
It's also useful as inspiration if users want to make their own
slightly tweaked rootfs-image type.
([MEN-2392](https://northerntech.atlassian.net/browse/MEN-2392))
* Swapped definition of StateScriptRetryTimeout and
StateScriptRetryInterval for the names to represent what they are
actually doing. This change breaks compatibility with current usage of
these configurable parameters. See documentation for correct usage.
([MEN-2409](https://northerntech.atlassian.net/browse/MEN-2409))
* Updated the copyright year to 2019 in LICENSE.
* Write update module for doing container setup
([MEN-2232](https://northerntech.atlassian.net/browse/MEN-2232))
* Add example update modules for shell commands and pkg installs.
* Remove misleading warning message when ServerCert is missing.
* Remove jq dependency for file-install Update Module
* Implement initial version of update modules.
([MEN-2000](https://northerntech.atlassian.net/browse/MEN-2000))
* Add support for Mender Artifact format version 3.
([MEN-2000](https://northerntech.atlassian.net/browse/MEN-2000))
* Artifact name is now stored in the local database, and
`/etc/mender/artifact_info` acts only as a fallback if no name has
been stored yet. This is typically the case for devices provisioned
directly from a disk image. Scripts should use the client
`-show-artifact` argument instead of parsing the file.
([MEN-2000](https://northerntech.atlassian.net/browse/MEN-2000))
* `-rootfs` argument has been removed and replaced with the
`-install` argument, which works the same way.
([MEN-2000](https://northerntech.atlassian.net/browse/MEN-2000))
* Mender now runs a stripped down set of state scripts when
installing artifacts in standalone mode, and the `-f` flag is no
longer required to install such artifacts, nor is it valid. The
scripts that run are:
* `Download` scripts
* `ArtifactInstall` scripts
* `ArtifactCommit` scripts
* `ArtifactRollback` scripts
* `ArtifactFailure` scripts
Reboot scripts do not run, so these must be handled manually in
standalone mode.
([MEN-2000](https://northerntech.atlassian.net/browse/MEN-2000))
* Behavior change: `ArtifactCommit_Error` scripts now run
after an `ArtifactCommit_Leave` script has returned an error.
([MEN-2000](https://northerntech.atlassian.net/browse/MEN-2000))
* Bugfix in killing mechanism for State Scripts
timing out ([MEN-2409](https://northerntech.atlassian.net/browse/MEN-2409))
* Update vendored dependency net/http2 to latest version
* Support installing most files using Makefile `install` target.
The device_type file is not supported, since it is highly hardware
specific. Also the configuration will be very bare bones, and will
require changes unless Hosted Mender is being used.
([MEN-2383](https://northerntech.atlassian.net/browse/MEN-2383))
* Make output from `-show-artifact` easier to consume by limiting logging.
* Fix state logic for the case of actual wait
([MEN-2195](https://northerntech.atlassian.net/browse/MEN-2195))
* Properly fail the update when writes to the underlying storage fail.
([MEN-2285](https://northerntech.atlassian.net/browse/MEN-2285))
* Work around occasional OOM bug in mmc driver.
([MEN-2285](https://northerntech.atlassian.net/browse/MEN-2285))
* Make sure state directory is created if it doesn't exist.

## mender 1.7.1

_Released 05.07.2019_

### Changelogs

#### mender (1.7.1)

New changes in mender since 1.7.0:

* Remove misleading warning message when ServerCert is missing.
* Bugfix: State-script error code in Sync-Enter causes infinite loop
([MEN-2195](https://northerntech.atlassian.net/browse/MEN-2195))
* Update vendored dependency net/http2 to latest version
* Rewrite AuthorizeWaitState to fix an infinite loop bug
([MEN-2195](https://northerntech.atlassian.net/browse/MEN-2195))
* Fix state logic for the case of actual wait
([MEN-2195](https://northerntech.atlassian.net/browse/MEN-2195))
* Make sure ARM64 is included in bootloader integration inventory.
* Mender no longer misidentifies LVM volumes.
([MEN-2302](https://northerntech.atlassian.net/browse/MEN-2302))
* Updated the copyright year to 2019 in LICENSE.

## mender 1.7.0

_Released 12.13.2018_

### Changelogs

#### mender (1.7.0)

New changes in mender since 1.7.0b1:

* Allow rootfsPartA and rootfsPartB to be symlinks

New changes in mender since 1.6.0:

* FIX: Enabling compiling ppc64le
* Fix active partition detection when using non-native
filesystems.
* Add inventory scripts for rootfs type and bootloader integration.
([MEN-2059](https://northerntech.atlassian.net/browse/MEN-2059))
* New feature: Fail-over Mender server(s)
([MEN-1972](https://northerntech.atlassian.net/browse/MEN-1972))
* New inventory script for "os" attribute, installed by default.
([MEN-2060](https://northerntech.atlassian.net/browse/MEN-2060))
* Mender client now loads configuration settings from
both /etc/mender/mender.conf and (if it exists)
/var/lib/mender/mender.conf. The second file is located
on the data partition, so it allows any subset of configuration
changes to survive upgrades.
([MEN-2073](https://northerntech.atlassian.net/browse/MEN-2073))
* Print a message to the mender log when the
mender client has confirmed the authenticity of an
artifact's digital signature.
([MEN-2152](https://northerntech.atlassian.net/browse/MEN-2152))
* Fix update check not working under BusyBox.
([MEN-2159](https://northerntech.atlassian.net/browse/MEN-2159))
* Add Community Code of Conduct
* Detect if inactive part is mounted and unmount
([MEN-2084](https://northerntech.atlassian.net/browse/MEN-2084))
* Improve error message when running mender as non-root user
([MEN-2083](https://northerntech.atlassian.net/browse/MEN-2083))

## mender 1.6.1

_Released 12.13.2018_

### Changelogs

#### mender (1.6.1)

New changes in mender since 1.6.0:

* Fix update check not working under BusyBox.
([MEN-2159](https://northerntech.atlassian.net/browse/MEN-2159))
* Print a message to the mender log when the
mender client has confirmed the authenticity of an
artifact's digital signature.
([MEN-2152](https://northerntech.atlassian.net/browse/MEN-2152))

## mender 1.6.0

_Released 09.18.2018_

### Changelogs

#### mender (1.6.0)

New changes in mender since 1.6.0b1:

* Fix active partition detection when using non-native
filesystems.
* New inventory script for "os" attribute, installed by default.
([MEN-2060](https://northerntech.atlassian.net/browse/MEN-2060))
* FIX: Enabling compiling ppc64le
* Add inventory scripts for rootfs type and bootloader integration.
([MEN-2059](https://northerntech.atlassian.net/browse/MEN-2059))

New changes in mender since 1.5.0:

* FIXED: HTTP error 401 is not handled by all states
([MEN-1854](https://northerntech.atlassian.net/browse/MEN-1854))
* ArtifactReboot_Enter scripts are no longer rerun
if interrupted by an unexpected reboot. It will be treated
as if Mender itself rebooted.
* Enable user to force an update-check locally
The user can now force an update check by either running mender with the
-check-update option, or send a signal [SIGUSR1] to the running mender process.
([MEN-1905](https://northerntech.atlassian.net/browse/MEN-1905))
* Add automatic check for canary value in U-Boot environment
to try to detect if there is a problem in the environment setup of
U-Boot and/or the u-boot-fw-utils tools.
* Mender client key generator script
* log active partition before and after reboot.
([MEN-1880](https://northerntech.atlassian.net/browse/MEN-1880))

## mender 1.5.1

_Released 09.18.2018_

### Changelogs

#### mender (1.5.1)

New changes in mender since 1.5.0:

* FIX: Enabling compiling ppc64le
* Fix active partition detection when using non-native
filesystems.


## mender 1.5.0b1

_Released 05.15.2018_

### Changelogs

#### mender (1.5.0b1)
* Regenerate keys on all key errors, not just when keys are missing.
([MEN-1823](https://northerntech.atlassian.net/browse/MEN-1823))
* cli: New client option to show installed artifact name
([MEN-1806](https://northerntech.atlassian.net/browse/MEN-1806))
* Spontaneous-reboot hardening of the client
([MEN-1187](https://northerntech.atlassian.net/browse/MEN-1187))
* FIXED: Log writes not flushed from memory
([MEN-1726](https://northerntech.atlassian.net/browse/MEN-1726))
* Allow multiple digit partition numbers.
* log request-id in case of bad API requests
([MEN-1738](https://northerntech.atlassian.net/browse/MEN-1738))
* Abort upgrade if artifact name is not retrievable from artifact_info
([MEN-1824](https://northerntech.atlassian.net/browse/MEN-1824))

## mender 1.5.0

_Released 06.07.2018_

### Changelogs

#### mender (1.5.0)
* FIXED: HTTP error 401 is not handled by all states
([MEN-1854](https://northerntech.atlassian.net/browse/MEN-1854))
* Mender client key generator script


## mender 1.4.1

_Released 06.04.2018_

### Changelogs

#### mender (1.4.1)
* FIXED: Log writes not flushed from memory
([MEN-1726](https://northerntech.atlassian.net/browse/MEN-1726))
* Regenerate keys on all key errors, not just when keys are missing.
([MEN-1823](https://northerntech.atlassian.net/browse/MEN-1823))
* Mender client key generator script


## mender 1.4.0b1

_Released 02.09.2018_

### Changelogs

#### mender (1.4.0b1)
* Report update status for scripts and states
([MEN-1015](https://northerntech.atlassian.net/browse/MEN-1015))
* Print detailed logs about authorization errors.
([MEN-1660](https://northerntech.atlassian.net/browse/MEN-1660), [MEN-1661](https://northerntech.atlassian.net/browse/MEN-1661))
* mender-device-identity: Check if file exists before reading
Mender on orangepi fails to run because identity script exit with error like:
/usr/share/mender/identity/mender-device-identity
cat: can't open '/sys/class/net/bonding_masters/type': Not a directory
Add check before reading type to avoid problems.
* Remove trailing slash from server URL configuration.
([MEN-1620](https://northerntech.atlassian.net/browse/MEN-1620))

## mender 1.4.0

_Released 03.20.2018_

### Changelogs

#### mender (1.4.0)
* Allow multiple digit partition numbers.


## mender 1.3.1

_Released 02.09.2018_

### Changelogs

#### mender (1.3.1)
* Print detailed logs about authorization errors.
([MEN-1660](https://northerntech.atlassian.net/browse/MEN-1660), [MEN-1661](https://northerntech.atlassian.net/browse/MEN-1661))

## mender 1.3.0b1

_Released 11.14.2017_

### Changelogs

#### mender (1.3.0b1)
* Mender now logs whatever a state-script outputs to stderr
([MEN-1349](https://northerntech.atlassian.net/browse/MEN-1349))
* mender-device-identity: only collect MAC from ARPHRD_ETHER types
* Fix 'unexpected EOF' error when downloading large updates.
([MEN-1511](https://northerntech.atlassian.net/browse/MEN-1511))
* Implement ability for client to resume a download from
where it left off if the connection is broken.
([MEN-1511](https://northerntech.atlassian.net/browse/MEN-1511))
* Improve error messages for state scripts errors.
Rely on the full error description instead of just the error code.
* Fix compile for ARM64.
* set return code = 2, when there is nothing to commit
* Added retry-later functionality on top of the state-script functionality
* Correctly fail state script execution if stderr can not be opened.
It would not be impossible to continue execution in this case, but it
is bad to lose log output, and not being able to open stderr is a
pretty uncommon case that might indicate a more serious issue like
resource starvation.

## mender 1.3.0

_Released 12.21.2017_

### Changelogs

#### mender (1.3.0)
* Remove trailing slash from server URL configuration.
([MEN-1620](https://northerntech.atlassian.net/browse/MEN-1620))


## mender 1.2.1

_Released 10.02.2017_

### Changelogs

#### mender (1.2.1)
* Improve error messages for state scripts errors.
Rely on the full error description instead of just the error code.
* Fix checksum not being verified for headers, only
payload. ([MEN-1412](https://northerntech.atlassian.net/browse/MEN-1412))

## mender 1.2.0

_Released 09.05.2017_

### Changelogs

#### mender (1.2.0)
* Refactored all store implementations into /store
* Improve error message when manifest field/file cannot be read.
* Fixed format check to conform to the expected artifact-file-format
([MEN-1289](https://northerntech.atlassian.net/browse/MEN-1289))
* installer: improve incompatible image error message
* Client will not run state scripts from cmd-line except when forced.
([MEN-1235](https://northerntech.atlassian.net/browse/MEN-1235))
* Fixed behaviour when no sys-cert is available on the system.
([MEN-1151](https://northerntech.atlassian.net/browse/MEN-1151))
* Mender now logs whatever a state-script outputs to stderr
([MEN-1349](https://northerntech.atlassian.net/browse/MEN-1349))
* Fix misleading version being displayed for non-tagged builds.
([MEN-1178](https://northerntech.atlassian.net/browse/MEN-1178))
* Changed the errormessage to more closely reflect the issue.
([MEN-1215](https://northerntech.atlassian.net/browse/MEN-1215))
* Removed the DeviceKey option in menderConfig.
* Fix - Now throws an error when committing nothing.
([MEN-505](https://northerntech.atlassian.net/browse/MEN-505))
* Introduction of state script feature. State scripts can be
used to execute scripts at various stages of Mender's execution. See
documentation for more information.
* Introduce experimental support for writing to UBI volumes
* Logs an error when device_type file not found.
([MEN-505](https://northerntech.atlassian.net/browse/MEN-505))
* remove no longer referenced client certificate code

## mender 1.1.2

_(Never released publicly)_

### Changelogs

#### mender (1.1.2)
* Fix checksum not being verified for headers, only
payload. ([MEN-1412](https://northerntech.atlassian.net/browse/MEN-1412))

