local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	s("ts", {
		t("#T="),
		i(1),
		t(" #S="),
		i(2), -- No "XX" default
	}),
}
