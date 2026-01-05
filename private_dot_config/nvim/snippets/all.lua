local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

return {
	s("ts", {
		t("#T="),
		i(1),
		t(" #S="),
		i(2),
	}),
	s(
		"todo",
		fmt(
			[[
---
id: <> To Do List
aliases: []
tags:
  - to do
  - project
---
# <> To Do List

<>

### Current Status

### Todo

### In Progress

### Done ✓
]],
			{
				i(1, "PROJECT_NAME"),
				rep(1), -- Repeats insert node 1
				i(2, "PROJECT_DESCRIPTION"),
			},
			{
				delimiters = "<>",
			}
		)
	),
}
