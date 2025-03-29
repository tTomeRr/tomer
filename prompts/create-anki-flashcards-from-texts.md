# Slide-to-Anki Flashcard Generator

## Context
This service creates high-quality Anki flashcards from presentation slides (PDF, PPTX) following scientific principles for effective learning. Each slide will be thoroughly analyzed to extract all key information and transformed into properly formatted flashcards optimized for memory retention.

## Input Options
- **Slides**: Upload your presentation slides (PDF or PPTX format)
- **Language Preference**: Specify the output language for flashcards (e.g., English, Hebrew, etc.)
- **Subject Area**: Optionally specify the academic subject to help with contextual understanding

## Output Format
- Flashcards delivered in CSV format using the pipe symbol (|) as separator between questions and answers
- Format: Question|Answer (one card per line)
- Organized by slide number for easy reference

## Triple Review Process
Each slide will undergo a thorough three-step analysis to ensure comprehensive coverage:
1. **Initial Extraction**: Identify main concepts, definitions, and key points
2. **Deep Analysis**: Uncover relationships, implications, and supporting details
3. **Verification Pass**: Ensure no important information is missed by re-examining the slide

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

## Anatomy of Good Flashcards
1. **Ultra-specific questions**: Use actual questions, not statements
   - Test understanding, not just completion ability
   - Questions should be clear even without context
   - Include the subject/topic in the question for clarity

2. **Focused answers**: Single concept, concise presentation
   - One key fact, name, concept, or term per answer
   - Avoid answers containing multiple independent facts
   - Present information clearly and concisely

## Language Considerations
- All flashcards will be generated in your specified language
- For technical terms, consider including both the term in the original language and its translation
- Maintain consistent terminology throughout the flashcard set

## Example
Original text:
"The characteristics of the Dead Sea: Salt lake located on the border between Israel and Jordan. Its shoreline is the lowest point on the Earth's surface, averaging 396 m below sea level. It is 74 km long. It is seven times as salty (30% by volume) as the ocean. Its density keeps swimmers afloat. Only simple organisms can live in its saline waters"

### Properly formatted flashcards:
Where is the Dead Sea located?|on the border between Israel and Jordan
What is the lowest point on the Earth's surface?|The Dead Sea shoreline
What is the average level on which the Dead Sea is located?|396 meters (below sea level)
How long is the Dead Sea?|74 km
How much saltier is the Dead Sea as compared with the oceans?|7 times
What is the volume content of salt in the Dead Sea?|30%
Why can the Dead Sea keep swimmers afloat?|due to high salt content
Why is the Dead Sea called Dead?|because only simple organisms can live in it
Why only simple organisms can live in the Dead Sea?|because of high salt content

### Examples of Poor Flashcards
- Overly broad: "Dead Sea facts|Israel/Jordan border, -396m, 74km long, 30% salt, floaty"
- Too vague: "Dead Sea?|Salt lake, very low, very salty"
- List overload: "What are all the characteristics of the Dead Sea?|It's a salt lake located on the border between Israel and Jordan, its shoreline is the lowest point on Earth's surface averaging 396m below sea level, it's 74km long, it's seven times as salty as the ocean (30% by volume), its density keeps swimmers afloat, and only simple organisms can live in its saline waters"
- Non-specific: "What makes the Dead Sea special?|It's really salty and you float in it and it's the lowest point on Earth"


## Process
For each slide, the system will:
1. Extract all key information through three thorough review passes
2. Create specific, focused questions for each concept
3. Provide concise, single-concept answers
4. Format output in proper CSV format with pipe separators
5. Include slide number references for easy navigation

## Your Task
Please upload your presentation slides and specify your preferred language for the flashcards. The slides will be analyzed and transformed into effective flashcards according to these principles and returned in the proper CSV format.
