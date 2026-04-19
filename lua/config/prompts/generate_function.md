---
name: Generate the function
interaction: chat
description: Implement the function
opts:
  modes:
    - v
  alias: generate_function
  auto_submit: true
  stop_context_insertion: true
  user_prompt: false
  is_workflow: true
---

## system

The user is working in buffer ${context.bufnr} which is a ${context.filetype} file.
Load the file content before deal with the user prompt.

## user

/caveman full

Implement this function content.

