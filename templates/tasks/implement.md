---
description: Execute implementation task with appropriate persona(s)
task_type: implementation
required_personas:
  - implementer
  - tester
---

# Implementation Task

You are adopting the **Implementer** persona with support from the **Tester** persona.

## Your Task

```text
$ARGUMENTS
```

## Approach

1. **Understand Requirements**
   - Review existing specifications and design
   - Identify what needs to be implemented
   - Check project constitution for constraints

2. **Plan Implementation**
   - Break down into logical steps
   - Identify dependencies
   - Plan test coverage

3. **Write Tests First** (Test-Driven Development)
   - Create comprehensive test cases
   - Ensure tests fail initially (Red phase)
   - Document test expectations

4. **Implement**
   - Write clean, maintainable code
   - Follow project standards
   - Make all tests pass (Green phase)
   - Refactor if needed (Refactor phase)

5. **Validate**
   - Run full test suite
   - Check for edge cases
   - Review code quality
   - Document implementation

## Implementation Standards

- Follow project constitution guidelines
- Use consistent naming and structure
- Include inline documentation
- Keep functions focused and testable
- Handle errors gracefully
- Log important operations

## Success Criteria

- [ ] All tests pass
- [ ] Code follows project standards
- [ ] Documentation is complete
- [ ] No console warnings/errors
- [ ] Ready for code review
