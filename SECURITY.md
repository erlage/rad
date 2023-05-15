## Security Policy

## Supported Versions

- Rad v1.x

## Security Releases

We are committed to supporting all major releases of the framework, including any future versions. However, please note that in the event of unexpected circumstances such as a shortage of maintainer capacity, we may need to discontinue support for older major versions.

**Example Scenario**

For instance, let's assume we have published Rad 2.x, and a security issue is discovered in version 1.2.0. In such a case, we will address the issue by releasing two separate updates, one for 1.x (e.g., 1.2.1) and one for 2.x (e.g., 2.0.1).

## Release Cadence

Our primary goal is to minimize breaking changes (major versions) as much as possible. However, there may be cases where major changes or functionality breaks become necessary. A major version change indicates that there may be significant changes or breaks in functionality. In some cases, we may release a major version out of an abundance of caution, even if there are no known backward compatibility breaks, particularly if there have been numerous internal changes.

When planning a major break in functionality for a new major release, and to gather feedback from the community before an official publication, we may utilize pre-release versions. For example, we may release an alpha version like 2.0.0-alpha.1 and subsequently publish additional pre-release versions based on the feedback received. Finally, the official release would be published as 2.0.0.

Please note that not all breaking changes will necessarily have pre-release versions.

## Backwards Compatibility

This is only guaranteed _within_ a major, not from one major to the next. [Semver](https://semver.org/) states that, "the major version is incremented if any backwards _incompatible_ changes are introduced." That is what we respect for the framework. Patches are bug fixes that remain backward compatible (to the current major), minors for new features (or significant internal changes) that remain backward-compatible (to the current major), and majors are for breaking changes (from the previous major).

While we strive to maintain backward compatibility and minimize breaking changes, there may be rare cases where a breaking change is unintentionally introduced. In such situations, we are committed to rectifying the issue promptly. We will either issue a subsequent release to address and fix the breaking change or take appropriate steps to retract the release and provide a resolution. We value the stability and compatibility of our framework and will make every effort to rectify any unintended breaking changes.

We appreciate your understanding and collaboration as we work diligently to deliver a reliable framework.

## Reporting Vulnerabilities

If you believe you have found a security vulnerability, please contact one of the maintainers directly and provide them with details, severity, and a reproduction. We would also welcome a suggested fix if you have one.

### Maintainers

- [H. Singh](mailto:hamsbrar@gmail.com)
