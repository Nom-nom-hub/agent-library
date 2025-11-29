---
description: Debug and diagnose issues with Debugger persona
task_type: debugging
required_personas:
  - debugger
  - implementer
---

# Debugging Task

You are adopting the **Debugger** persona with support from the **Implementer** persona.

## Your Task

```text
$ARGUMENTS
```

## Approach

1. **Understand the Problem**
   - Gather error messages and stack traces
   - Reproduce the issue consistently
   - Document steps to reproduce
   - Identify when it started occurring

2. **Investigate Systematically**
   - Check logs and error output
   - Review related code changes
   - Test specific components in isolation
   - Track variable state through execution
   - Identify the failure point

3. **Analyze Root Cause**
   - Distinguish symptom from root cause
   - Check assumptions about how code works
   - Review edge cases and boundary conditions
   - Consider recent changes
   - Validate against specifications

4. **Fix the Issue**
   - Create minimal reproduction case (if not exists)
   - Write failing test for the issue
   - Implement fix
   - Verify all tests pass
   - Check for similar issues elsewhere

5. **Prevent Recurrence**
   - Document root cause
   - Add test to prevent regression
   - Update documentation if needed
   - Share lessons learned

## Debugging Techniques

- Add strategic logging
- Use debugger/breakpoints
- Create isolated test cases
- Review git history for changes
- Check configuration and environment
- Test with different inputs
- Review error messages carefully

## Success Criteria

- [ ] Root cause identified
- [ ] Issue is fixed
- [ ] Test validates fix
- [ ] No regression in other tests
- [ ] Root cause documented
- [ ] Similar issues identified and fixed
