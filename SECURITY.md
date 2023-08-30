## Security Policy

## Supported Versions

- Rad v1.x

## Security Releases

We are committed to supporting all major releases of the framework, including any future versions. However, please note that in the event of unexpected circumstances such as a shortage of maintainer capacity, we may need to discontinue support for older major versions.

**Example Scenario**

For instance, let's assume we have published Rad 2.x, and a security issue is discovered in version 1.2.0. In such a case, we will address the issue by releasing two separate updates, one for 1.x (e.g., 1.2.1) and one for 2.x (e.g., 2.0.1).

## Backwards Compatibility

Our primary goal is to minimize breaking changes (major versions) as much as possible. However, there may be cases where major changes or functionality breaks become necessary. A major version change indicates that there may be significant changes or breaks in functionality. In some cases, we may release a major version out of an abundance of caution, even if there are no known backward compatibility breaks, particularly if there have been numerous internal changes.

When planning a major break in functionality for a new major release, and to gather feedback from the community before an official publication, we may utilize pre-release versions. For example, we may release an alpha version like 2.0.0-alpha.1 and subsequently publish additional pre-release versions based on the feedback received. Finally, the official release would be published as 2.0.0.

Please be aware that not all breaking changes will be accompanied by pre-release versions or major versions. We refrain from releasing major versions solely to address fundamental framework issues. When such issues are inherent in the framework design and are likely to impact users, our approach is to offer early notification by introducing these breaking changes in minor versions. It's worth noting that these types of changes are infrequent, with only [one instance](https://github.com/erlage/rad/commit/b9ba436921209cf32af2afabc36b6355ff9a73e9) recorded at the time of writing.

### Maintainers

- [hamsbrar](mailto:hamsbrar@gmail.com)
