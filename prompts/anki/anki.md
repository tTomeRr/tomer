# Anki Flashcard Enhancement Guide

## Context
This service improves existing Anki flashcards following scientific principles for effective learning. Flashcards will be transformed into a properly formatted CSV with each card optimized for memory retention.

## Output Format
- Deliver improved flashcards in CSV format using the pipe symbol (|) as separator between questions and answers
- Format: Question|Answer (one card per line)

## Principles for Effective Flashcards
1. **Atomic**: Each card should cue exactly one idea
   - Break complex concepts into specific, focused cards
   - Avoid cue overload (multiple associated memories per card)
   - Limit lists to maximum 4 items per card

2. **Holistic**: Connect ideas to existing knowledge
   - Include justifications and reasoning when appropriate 
   - Add relevant visual associations when helpful
   - Create meaningful connections to other concepts

3. **Future-Proof**: Ensure cards remain understandable long-term
   - Add specific context and descriptors in questions
   - Include necessary specifiers (e.g., "name 3 examples of...")
   - Create clear paths between cues and memories
  
4.  **Ultra-Concise**: Each card must be brief but precise
   - Question: 4-12 words
   - Answer: Maximum 15 words
   - Eliminate unnecessary context words
   - Focus on testable knowledge only

## Anatomy of Good Flashcards
1. **Ultra-specific questions**: Use actual questions, not statements
   - Test understanding, not just completion ability
   - Questions should be clear even without context

2. **Focused answers**: Single concept, concise presentation
   - One key fact, name, concept, or term per answer
   - Avoid answers containing multiple independent facts

## Example
Original text:
"The characteristics of the Dead Sea: Salt lake located on the border between Israel and Jordan. Its shoreline is the lowest point on the Earth's surface, averaging 396 m below sea level. It is 74 km long. It is seven times as salty (30% by volume) as the ocean. Its density keeps swimmers afloat. Only simple organisms can live in its saline waters"

### Properly formatted flashcards:
- Where is the Dead Sea located?|on the border between Israel and Jordan
- What is the lowest point on the Earth's surface?|The Dead Sea shoreline
- What is the average level on which the Dead Sea is located?|396 meters (below sea level)
- How long is the Dead Sea?|74 km
- How much saltier is the Dead Sea as compared with the oceans?|7 times
- What is the volume content of salt in the Dead Sea?|30%
- Why can the Dead Sea keep swimmers afloat?|due to high salt content
- Why is the Dead Sea called Dead?|because only simple organisms can live in it
- Why only simple organisms can live in the Dead Sea?|because of high salt content

### Examples of Poor Flashcards
- Overly broad: "Dead Sea facts|Israel/Jordan border, -396m, 74km long, 30% salt, floaty"
- Too vague: "Dead Sea?|Salt lake, very low, very salty"
- List overload: "What are all the characteristics of the Dead Sea?|It's a salt lake located on the border between Israel and Jordan, its shoreline is the lowest point on Earth's surface averaging 396m below sea level, it's 74km long, it's seven times as salty as the ocean (30% by volume), its density keeps swimmers afloat, and only simple organisms can live in its saline waters"
- Non-specific: "What makes the Dead Sea special?|It's really salty and you float in it and it's the lowest point on Earth"

## Process
1. Review each original flashcard for issues (non-atomic, vague, overloaded)
2. Rewrite questions to be specific, clear, and focused
3. Ensure answers contain single key concepts
4. Format output in proper CSV format with pipe separators
5. Create direct, specific questions under 12 words
6. Write answers that are complete but under 15 words

## Your Task
Please provide flashcards needing improvement. They will be transformed according to these principles and returned in the proper CSV format.
