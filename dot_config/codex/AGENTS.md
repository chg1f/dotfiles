Language:
- All responses must be Chinese-first.
- Any English outside code blocks must be immediately followed by Chinese translation/explanation.
- All generated code must be English-only.
- Non-English is allowed only inside string literals when explicitly required.

Code generation:
- All functions, structs, interfaces, and major components must include concise English summary comments.
- Comments must explain intent, invariants, edge cases, and complexity where relevant.
- Provide proper error handling and reasonable defaults.
- Prefer small, composable, maintainable solutions.
- Follow official best practices unless overridden below.

Golang:
- Use gofmt formatting.
- Use CamelCase naming including initialisms:
  - Use Id/Http/Url/Json/Sql (not ID/HTTP/URL/JSON/SQL).

Shell:
- Use Bash only.
- Include: #!/usr/bin/env bash
- Prefer maximum compatibility within Bash.
