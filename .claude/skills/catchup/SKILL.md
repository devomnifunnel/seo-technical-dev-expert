---
name: catchup
description: >
  Use when someone asks to catch up, restore context, resume where we left off, or reload
  client state after a break. Trigger on: "catch up", "what did I miss", "resume context",
  "load client state", "where were we", "what was I working on", "restore session",
  "reload context", "pick up where we left off". This is the context restoration protocol
  that runs after /clear or session restart to reload project state, recent activity,
  client context, and Asana board status.
disable-model-invocation: true
argument-hint: "[client-name (optional)]"
allowed-tools: Read, Grep, Glob, Agent
---

# Context Restoration Protocol

After a /clear or session restart, restore essential working context.

## Step 1: Load Project State

Read the CLAUDE.md file to reload project instructions:
- Read .claude/CLAUDE.md

## Step 2: Check Recent Activity

Find recently modified files to understand what was being worked on:
- Run: `git log --oneline -15` to see recent commits
- Run: `git diff --name-only HEAD~5` to see recently changed files
- Read any files modified in the last session that are relevant to current work

## Step 3: Load Client Context

If a specific client was mentioned or is the focus:
- Check clients/ for the client folder
- Read clients/[name]/history.md for the most recent 5 entries
- Read clients/[name]/open-items.md for pending work

## Step 4: Check Asana Board

Read the Claude Asana board for active tasks:
- Check Active Client Work section for in progress items
- Check any tasks assigned or recently updated

## Step 5: Summarize State

Present a brief summary to Michael:
- What was last worked on
- What open items exist
- What the current session should focus on (ask if unclear)

Keep this restoration lightweight. Target under 5,000 tokens total for the catchup process.
