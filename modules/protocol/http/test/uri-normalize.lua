local http = require('protocol/http')

local _test = {
	['HTTP://example.com/'] =  'http://example.com/',
    ['http://EXAMPLE.COM/'] = 'http://example.com/',
    ['http://example.com/%7Efoo'] = 'http://example.com/~foo',
    ['http://example.com/?q=1%2f2'] = 'http://example.com/?q=1%2F2',
    ['http://example.com/a/./b'] = 'http://example.com/a/b',
    ['http://example.com/a/../a/b'] = 'http://example.com/a/b',
    ['http://example.com'] = 'http://example.com/',
    ['http://example.com:80/'] = 'http://example.com/',
    ['htTp://wWw.foo.coM:80/foo/./baz/../bar/%7Eb%61r?test=1#noise'] = 'http://www.foo.com/foo/bar/~bar?test=1#noise',
    ['http://USER:pass@www.Example.COM/foo/bar'] = 'http://USER:pass@www.example.com/foo/bar',
    ['http://www.w3.org/2000/01/rdf-schema'] = 'http://www.w3.org/2000/01/rdf-schema',
    ['www.example.com/foo/bar'] = 'http://www.example.com/foo/bar',
    ['/'] = '/',

	-- check normalisation errors
	[''] =  '',
	['://'] = '',
	['#'] = '',
	[':@'] = '/',
	['http:///'] = '/',
	['http://http://'] = 'http://http://'
}

for k, v in pairs(_test) do
	local normalized = http.uri.normalize(k)
	print('normal =', '[' ..normalized .. ']')
	print('normalizing uri : ' .. k)
	if v ~= normalized then
		error('\nfailed to normalize: ' .. k .. '\nexpected: ' .. v .. ' got ' .. normalized)
	end
end
