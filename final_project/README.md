# Command-Line Chess Application (Ruby)

## Overview

This repository documents the design, structure, and technical requirements for building a fully functional command-line Chess game in Ruby.

The goal is to demonstrate the ability to design a large, stateful, rule-driven system, applying object-oriented principles, clean architecture, and disciplined problem decomposition. This is a capstone-level exercise focused on reasoning, correctness, and maintainability, not just syntax.



## Core Objectives

- Implement a complete two-player Chess game in the terminal
- Enforce all standard chess rules
- Validate and reject illegal moves
- Detect and announce check and checkmate
- Persist and restore game state
- Maintain modular, testable, and readable code
- Use automated tests to verify core logic



## Functional Requirements

### Game Flow

- Two human players alternate turns
- The board state is displayed after each move
- Input is taken via standard input
- Turns continue until:
  - Checkmate
  - Stalemate
  - Manual exit



### Board Representation

- 8×8 grid
- Each square may contain:
  - A piece
  - Or be empty
- Coordinates must map cleanly between:
  - Internal representation
  - User input (algebraic or numeric)

Unicode chess symbols may be used for clarity and aesthetics.



### Pieces & Movement

Each piece must:
- Belong to a color
- Know its position
- Know how it can legally move

Required pieces:
- King
- Queen
- Rook
- Bishop
- Knight
- Pawn

Movement rules must include:
- Sliding vs discrete moves
- Blocking and capture rules
- Pawn-specific logic:
  - First move double-step
  - Diagonal captures
  - Promotion
  - En passant (optional but recommended)



### Move Validation

A move is legal only if:
- The piece exists
- The destination is reachable by the piece
- The destination is not blocked illegally
- The move does not leave the current player in check

Illegal moves must be rejected gracefully with feedback.



### Check & Checkmate

- A king is in check if an opposing piece can capture it
- A position is checkmate if:
  - The king is in check
  - No legal move can remove the check

These conditions must be evaluated dynamically after each move.



## Architecture & Design

### Recommended Class Structure

- `Game`
  - Controls turn order and game loop
- `Board`
  - Stores and updates piece positions
- `Piece` (base class)
  - Shared behavior
- Subclasses:
  - `King`, `Queen`, `Rook`, `Bishop`, `Knight`, `Pawn`
- `Player`
  - Color
  - Turn ownership
- Optional:
  - `Move`
  - `Position`

Each class should have one clear responsibility.


### Separation of Concerns

- Input handling must be separate from game logic
- Move validation must not mutate board state prematurely
- Display logic must not contain rules
- Rule checks must not print output

This separation is critical for testing.



## Saving and Loading

The game state must be serializable:
- Board layout
- Piece states
- Current turn
- Any special flags (castling rights, en passant, etc.)

Ruby tools to consider:
- `Marshal`
- `YAML`

Saving should be possible at any point during gameplay.



## Testing Strategy

Use RSpec to test:

- Piece movement logic
- Check detection
- Checkmate detection
- Illegal move rejection
- Serialization and restoration

Tests should focus on:
- Pure logic
- Deterministic outcomes
- Edge cases

Manual testing via terminal input should be minimized.



## Example Logic Snippet

```ruby
class Piece
  attr_reader :color, :position

  def initialize(color, position)
    @color = color
    @position = position
  end

  def moves(board)
    raise NotImplementedError
  end
end
```

Each subclass implements its own movement rules.


## Input Format

The system should accept moves in a consistent format, such as:
- `e2 e4`
- `b1 c3`

Input must be validated before execution.

## Development Guidelines

- Keep methods short and focused
- Avoid deeply nested conditionals
- Prefer clarity over cleverness
- Refactor aggressively
- Write tests before debugging manually



## Key Skills Demonstrated

- Object-Oriented Design
- State management
- Rule enforcement
- Algorithmic reasoning
- Testing discipline
- Large-project organization
