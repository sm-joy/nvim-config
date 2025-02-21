local ls = require('luasnip')
local snippets = {
    cpp = {
        ls.parser.parse_snippet("main", [[
#include <iostream>

int main() {

    return 0;
}
]]),
        ls.parser.parse_snippet("cp", [[
#include <bits/stdc++.h>

using namespace std;
#define ll long long
#define pb push_back
#define vi vector<int>
#define all(x) x.begin(), x.end()
#define sz(x) (int)(x).size()
#define FAST_IO() ios_base::sync_with_stdio(false); cin.tie(NULL);

int main() {
    FAST_IO();
    
    int t; cin >> t;
    while (t--) {
        
    }

    return 0;
}
]])
    },
    c = {
        ls.parser.parse_snippet("main", [[
#include <stdio.h>

int main() {
    
    return 0;
}
]]),
        ls.parser.parse_snippet("hg", [[
#ifndef ${1:HEADER_NAME}_H
#define ${1:HEADER_NAME}_H


#endif // ${1:HEADER_NAME}_H
]]),
    }
}


for filetype, snippets in pairs(snippets) do
    ls.add_snippets(filetype, snippets)
end

