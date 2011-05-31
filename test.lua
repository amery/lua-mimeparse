local mp = assert(require"mimeparse")

-- public void testParseMediaRange()
--     {
--         assertEquals("('application', 'xml', {'q':'1',})", MIMEParse
--                 .parseMediaRange("application/xml;q=1").toString());
--         assertEquals("('application', 'xml', {'q':'1',})", MIMEParse
--                 .parseMediaRange("application/xml").toString());
--         assertEquals("('application', 'xml', {'q':'1',})", MIMEParse
--                 .parseMediaRange("application/xml;q=").toString());
--         assertEquals("('application', 'xml', {'q':'1',})", MIMEParse
--                 .parseMediaRange("application/xml ; q=").toString());
--         assertEquals("('application', 'xml', {'b':'other','q':'1',})",
--                 MIMEParse.parseMediaRange("application/xml ; q=1;b=other")
--                         .toString());
--         assertEquals("('application', 'xml', {'b':'other','q':'1',})",
--                 MIMEParse.parseMediaRange("application/xml ; q=2;b=other")
--                         .toString());
--         // Java URLConnection class sends an Accept header that includes a
--         // single *
--         assertEquals("('*', '*', {'q':'.2',})", MIMEParse.parseMediaRange(
--                 " *; q=.2").toString());
--     }
-- 
--     public void testRFC2616Example()

accept = "text/*;q=0.3, text/html;q=0.7, text/html;level=1, text/html;level=2;q=0.4, */*;q=0.5"
assert(1.0 == mp.quality("text/html;level=1", accept))
assert(0.7 == mp.quality("text/html", accept))
assert(0.3 == mp.quality("text/plain", accept))
assert(0.5 == mp.quality("image/jpeg", accept))
assert(0.4 == mp.quality("text/html;level=2", accept))
assert(0.7 == mp.quality("text/html;level=3", accept))

--     public void testBestMatch()

mimeTypesSupported = { "application/xbel+xml", "application/xml" }

--			// direct match
assert(mp.best_match(mimeTypesSupported, "application/xbel+xml") == "application/xbel+xml")
--         // direct match with a q parameter
assert(mp.best_match(mimeTypesSupported, "application/xbel+xml;q=1") == "application/xbel+xml")
--         // direct match of our second choice with a q parameter
assert(mp.best_match(mimeTypesSupported, "application/xml;q=1") == "application/xml")
--         // match using a subtype wildcard
assert(mp.best_match(mimeTypesSupported, "application/*;q=1") ==  "application/xml")
--         // match using a type wildcard
assert(mp.best_match(mimeTypesSupported, "*/*") == "application/xml")

mimeTypesSupported = { "application/xbel+xml", "text/xml" }

--         // match using a type versus a lower weighted subtype
assert(mp.best_match(mimeTypesSupported, "text/*;q=0.5,*/*;q=0.1") == "text/xml")
--         // fail to match anything
assert(mp.best_match(mimeTypesSupported, "text/html,application/atom+xml; q=0.9") == "")

--         // common AJAX scenario
mimeTypesSupported = { "application/json", "text/html" }
assert(mp.best_match(mimeTypesSupported, "application/json,text/javascript, */*") == "application/json")

--         // verify fitness ordering
assert(mp.best_match(mimeTypesSupported, "application/json,text/html;q=0.9") == "application/json")

--     public void testSupportWildcards()

mimeTypesSupported = { "image/*", "application/xml" }

--         // match using a type wildcard
assert(mp.best_match(mimeTypesSupported, "image/png") == "image/*")
--         // match using a wildcard for both requested and supported
assert(mp.best_match(mimeTypesSupported, "image/*") == "image/*")
