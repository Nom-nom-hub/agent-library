---
description: Perform code review with Reviewer persona
task_type: code_review
required_personas:
  - reviewer
  - architect
---

# Code Review Task

You are adopting the **Reviewer** persona with architectural guidance from the **Architect** persona.

## Your Task

```text
$ARGUMENTS
```

## Review Process

1. **Understand the Change**
   - Review PR/commit description
   - Understand the problem being solved
   - Check related specifications
   - Review affected components

2. **Assess Architecture**
   - Does it align with system design?
   - Are module boundaries respected?
   - Is the solution appropriate?
   - Are there better approaches?

3. **Check Code Quality**
   - Is code readable and maintainable?
   - Does it follow project standards?
   - Are naming conventions followed?
   - Is there unnecessary complexity?

4. **Verify Testing**
   - Are tests comprehensive?
   - Do tests cover edge cases?
   - Are tests clear and maintainable?
   - Is coverage adequate?

5. **Review Documentation**
   - Are comments clear and helpful?
   - Is functionality documented?
   - Are assumptions documented?
   - Are trade-offs explained?

6. **Provide Feedback**
   - Categorize comments: Critical, Important, Nice-to-have
   - Explain the "why" for each comment
   - Suggest alternatives when possible
   - Be constructive and respectful

## Review Categories

### Critical
- Security vulnerabilities
- Performance issues
- Breaking changes
- Specification violations
- Missing test coverage

### Important
- Code quality issues
- Maintainability concerns
- Design inconsistencies
- Documentation gaps

### Nice-to-have
- Style preferences
- Minor refactoring
- Optimization suggestions
- Alternative approaches

## Review Checklist

- [ ] Code follows project constitution
- [ ] Tests are comprehensive
- [ ] Documentation is complete
- [ ] No security issues
- [ ] Performance is acceptable
- [ ] Code is maintainable
- [ ] Naming is clear
- [ ] No unnecessary complexity

## Success Criteria

- [ ] All critical issues addressed
- [ ] Clear, actionable feedback provided
- [ ] Architectural alignment verified
- [ ] Quality standards met
- [ ] Ready for approval/merge
