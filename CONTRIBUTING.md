# Contributing to KatanaSwift

Thank you for your interest in contributing to KatanaSwift! We welcome contributions of all kinds, including new features, bug fixes, and improvements to documentation.

## How to Contribute

1.  **Fork the Repository**: Create your own copy of the repository on GitHub.
2.  **Clone Locally**: `git clone https://github.com/Henryforce/KatanaSwift.git`
3.  **Create a Branch**: Use a descriptive name for your branch (e.g., `feature/new-effect` or `fix/io-bug`).
4.  **Make Changes**: Ensure your code follows the project's formatting standards.
5.  **Write Tests**: If you're adding a new feature or fixing a bug, please include tests to verify your changes.
6.  **Run Tests Locally**: Ensure all tests pass before submitting your PR.
7.  **Submit a Pull Request**: Provide a clear description of your changes and why they are needed.

## Code Style & Formatting

Please run the following command on your changes before submitting:

```bash
swift format . --recursive --in-place
```

## Adding New MIDI Parameters

If you're adding support for new effects or parameters, please follow these guidelines:

1.  **Define the Bank**: Create a new `struct` in `Sources/KatanaGoData` and use the `@KatanaBank` macro.
2.  **Verify Addresses**: Double-check the Roland/Boss SysEx addresses. If you've reverse-engineered new addresses, please document your findings in your PR description.
3.  **Update the Parser**: Add your new bank to `KatanaGoSysExParser.swift` so that incoming device updates are correctly serialized into your new models.
4.  **Add Test Cases**: Add a new test in `KatanaGoSysExParserTests.swift` and inside the `KatanaGoDataTests` target.

## License

By contributing to KatanaSwift, you agree that your contributions will be licensed under the project's **Apache License 2.0**.
