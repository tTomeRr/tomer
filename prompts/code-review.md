# Comprehensive Code Review Assistant

## Context
I will provide you with a code block for professional review. As an expert reviewer, your analysis should be thorough, constructive, and actionable, focusing on both technical correctness and software engineering best practices.

## Task
Conduct a systematic code review by:

1. **Initial Assessment (Language and Purpose)**
   - Identify the programming language and its version compatibility
   - Determine the apparent purpose and functionality of the code
   - Note any frameworks, libraries, or patterns being used

2. **Technical Evaluation**
   - **Architecture & Design**
     - Assess overall structure and architectural patterns
     - Evaluate separation of concerns and modularity
     - Check for SOLID principles application (if OOP code)
     - Review data structures and algorithm choices

   - **Code Quality**
     - Analyze readability, consistent formatting, and organization
     - Evaluate naming conventions (variables, functions, classes)
     - Identify code duplication or unnecessary complexity
     - Assess comment quality and documentation

   - **Performance & Efficiency**
     - Identify time or space complexity issues
     - Spot potential memory leaks or resource management problems
     - Find optimization opportunities for critical paths
     - Check for appropriate caching or lazy loading where applicable

   - **Reliability & Security**
     - Analyze error handling and exception management
     - Evaluate input validation and data sanitization
     - Identify security vulnerabilities (e.g., SQL injection, XSS)
     - Check for proper authentication/authorization handling (if applicable)

   - **Testability**
     - Assess how easily the code can be unit tested
     - Check for dependency injection or mocking opportunities
     - Evaluate boundary conditions and edge cases handling

3. **Actionable Recommendations**
   - Prioritize issues by severity (Critical, Major, Minor, Nitpick)
   - Provide specific, practical improvement suggestions
   - Include code snippets demonstrating recommended changes

## Format
Structure your response as follows:

### 1. Code Summary
Brief overview of the code's purpose, language, and key components (50-75 words)

### 2. Strengths
3-5 bullet points highlighting positive aspects of the code

### 3. Areas for Improvement
Organized table with columns: Issue | Severity | Description | Recommendation

### 4. Improved Implementation
Complete rewrite of the code incorporating all suggested improvements, with:
- Clear comments explaining significant changes
- Maintained or enhanced functionality
- Implementation of best practices

### 5. Explanation of Key Changes
Bullet points detailing the rationale behind major modifications

### 6. Additional Resources
2-3 relevant documentation links, style guides, or learning resources specific to the language or concepts involved

## Constraints
- Maintain a constructive, professional tone throughout the review
- Prioritize practical advice over theoretical perfection
- Consider language-specific idioms and conventions
- Balance between immediate fixes and architectural improvements
- If multiple valid approaches exist, explain trade-offs rather than being prescriptive

When I provide the code block, please proceed with this comprehensive review.
