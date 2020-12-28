--[=[
	Version 2.3.0
	This is intended for Roblox ModuleScripts
	BSD 2-Clause Licence
	Copyright ©, 2020 - Blockzez (devforum.roblox.com/u/Blockzez and github.com/Blockzez)
	All rights reserved.
	
	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions are met:
	
	1. Redistributions of source code must retain the above copyright notice, this
	   list of conditions and the following disclaimer.
	
	2. Redistributions in binary form must reproduce the above copyright notice,
	   this list of conditions and the following disclaimer in the documentation
	   and/or other materials provided with the distribution.
	
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
	DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
	FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
	DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
	SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
	CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
	OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
	OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]=]--
local f = { };

function f.AbbreviationToCLDR(abbreviations, is_ldml)
	local ret = is_ldml and { '<decimalFormatLength type="short">\n\t<decimalFormat>\n' } or { };
	for i, p in ipairs(abbreviations) do
		for zcount = 1, 3 do
			if p == '' or not p then
				table.insert(ret, '0');
			else
				local v = ('0'):rep(zcount) .. p:gsub('¤', "'¤'"):gsub('‰', "'‰'"):gsub("'", "''"):gsub("[.;,#%%]", "'%1'");
				if is_ldml then
					table.insert(ret, ('\t\t<pattern type="1%s" count="one">%s</pattern>\n'):format(('0'):rep((i * 3) + (zcount - 1)), v));
					v = ('\t\t<pattern type="1%s" count="other">%s</pattern>\n'):format(('0'):rep((i * 3) + (zcount - 1)), v);
				end;
				table.insert(ret, v);
			end;
		end;
	end;
	if is_ldml then
		table.insert(ret, "\t</decimalFormat>\n</decimalFormatLength>");
		return table.concat(ret);
	end;
	return ret;
end;

-- Berezaa's suffix
local defaultCompactPattern = f.AbbreviationToCLDR {
	-- https://minershaven.fandom.com/wiki/Cash_Suffixes
	"k", "M", "B", "T", "qd", "Qn", "sx", "Sp", "O", "N", "de", "Ud", "DD", "tdD",
	"qdD", "QnD", "sxD", "SpD", "OcD", "NvD", "Vgn", "UVg", "DVg", "TVg", "qtV",
	"QnV", "SeV", "SPG", "OVG", "NVG", "TGN", "UTG", "DTG", "tsTG", "qtTG", "QnTG",
	"ssTG", "SpTG", "OcTG", "NoTG", "QdDR", "uQDR", "dQDR", "tQDR", "qdQDR", "QnQDR",
	"sxQDR", "SpQDR", "OQDDr", "NQDDr", "qQGNT", "uQGNT", "dQGNT", "tQGNT", "qdQGNT",
	"QnQGNT", "sxQGNT", "SpQGNT", "OQQGNT", "NQQGNT", "SXGNTL", "USXGNTL", "DSXGNTL",
	"TSXGNTL", "QTSXGNTL", "QNSXGNTL", "SXSXGNTL", "SPSXGNTL", "OSXGNTL", "NVSXGNTL",
	"SPTGNTL", "USPTGNTL", "DSPTGNTL", "TSPTGNTL", "QTSPTGNTL", "QNSPTGNTL", "SXSPTGNTL",
	"SPSPTGNTL", "OSPTGNTL", "NVSPTGNTL", "OTGNTL", "UOTGNTL", "DOTGNTL", "TOTGNTL", "QTOTGNTL",
	"QNOTGNTL", "SXOTGNTL", "SPOTGNTL", "OTOTGNTL", "NVOTGNTL", "NONGNTL", "UNONGNTL", "DNONGNTL",
	"TNONGNTL", "QTNONGNTL", "QNNONGNTL", "SXNONGNTL", "SPNONGNTL", "OTNONGNTL", "NONONGNTL", "CENT", "UNCENT",
};

local sym_tables = { '¤', '%', '-', '+', 'E', '‰', '*' };
local function generatecompact(ptn)
	local org_ptn = ptn;
	if type(ptn) ~= "string" then
		error("Compact patterns must be a table of string", 4);
	end;
	local ret, size, i0 = { }, 0, 1;
	while i0 do
		local i1 = math.min(ptn:find("[0-9@#.,+%%;*'-]", i0) or #ptn + 1, ptn:find('¤', i0) or #ptn + 1, ptn:find('‰', i0) or #ptn + 1);
		local i2 = i1 + ((ptn:sub(i1, i1 + 1) == '¤' or ptn:sub(i1, i1 + 1) == '‰') and 1 or 0);
		local chr = ptn:sub(i1, i2);
		-- Literal charaters
		if chr == "'" then
			local r = ptn:sub(i0, i1 - 1);
			i0 = ptn:find("'", i1 + 1);
			if i0 == i1 + 1 then
				r ..= r "'";
			elseif i0 then
				r ..= ptn:sub(i1 + 1, i0 - 1);
			else
				error("'" .. org_ptn .. "' is not a valid pattern", 4);
			end;
			if r then
				table.insert(ret, r);
			end;
			i0 += 1;
		elseif chr:match('[1-9]') then
			error("The rounding (1-9) pattern isn't supported", 4);
		elseif chr == '¤' or chr == '‰' or chr:match('[%%*+%-]') then
			error("The '" .. chr .. "' pattern isn't supported", 4);
		elseif chr == '0' then
			if size > 0 then
				error("'" .. org_ptn .. "' is not a valid pattern", 4);
			end;
			if i0 ~= i1 then
				table.insert(ret, ptn:sub(i0, i1 - 1));
			end;
			table.insert(ret, 0);
			
			i0 = ptn:find('[^0]', i1);
			local int = ptn:sub(i1, (i0 or #ptn + 1) - 1);
			
			if (not int:match('^0+$')) or size > 0 then
				error("'" .. org_ptn .. "' is not a valid pattern", 4);
			end;
			
			size = #int;
		else
			table.insert(ret, ptn:sub(i0));
			i0 = nil;
		end;
	end;
	
	return ret, size;
end;

-- From International, modified
local valid_value_property =
{
	groupSymbol = "f/str",
	decimalSymbol = "f/str",
	compactPattern = "f/table",
	
	style = { "decimal", "currency", "percent", "unit" },
	useGrouping = { "min2", "always", "never" },
	minimumIntegerDigits = "f/1..",
	maximumIntegerDigits = "f/minimumIntegerDigits..inf",
	minimumFractionDigits = "f/0..",
	maximumFractionDigits = "f/minimumFractionDigits..inf",
	minimumSignificantDigits = "f/1..",
	maximumSignificantDigits = "f/minimumSignificantDigits..inf",
	currency = "f/str",
	rounding = { "halfUp", "halfEven", "halfDown", "up", "down" },
	
	minimumSignificantDigitsToKeep = "f/1..",
	trailingZeroesIfRounded = "f/0..",
	
	compactFallback = { "last", "scientific", "standard" },
	
	exponentLowercased = "f/bool",
	engineering = "f/bool",
	
	rangeIdentityFallback = { "singleValue", "approximately", "approximatelyOrSingleValue", "range" },
	rangeCollapse = { "none", "unit", "all" },
	
	numberingSystem = { },
};

local numbering_system = {
	arab = { '٠','١','٢','٣','٤','٥','٦','٧','٨','٩' },
	arabtext = { '۰','۱','۲','۳','۴','۵','۶','۷','۸','۹' },
	beng = { '০','১','২','৩','৪','৫','৬','৭','৮','৯' },
	deva = { '०','१','२','३','४','५','६','७','८','९' },
	fullwide = { '０', '１', '２', '３', '４', '５', '６', '７', '８', '９' },
	hanidec = { '〇','一','二','三','四','五','六','七','八','九' },
	mathbold = { '𝟎', '𝟏', '𝟐', '𝟑', '𝟒', '𝟓', '𝟔', '𝟕', '𝟖', '𝟗' },
	mathdbl = { '𝟘', '𝟙', '𝟚', '𝟛', '𝟜', '𝟝', '𝟞', '𝟟', '𝟠', '𝟡' },
	mathmono = { '𝟶', '𝟷', '𝟸', '𝟹', '𝟺', '𝟻', '𝟼', '𝟽', '𝟾', '𝟿' },
	mathsanb = { '𝟬', '𝟭', '𝟮', '𝟯', '𝟰', '𝟱', '𝟲', '𝟳', '𝟴', '𝟵' },
	mathsans = { '𝟢', '𝟣', '𝟤', '𝟥', '𝟦', '𝟧', '𝟨', '𝟩', '𝟪', '𝟫' },
	mymr = { '၀','၁','၂','၃','၄','၅','၆','၇','၈','၉' },
	olck = { '᱐','᱑','᱒','᱓','᱔','᱕','᱖','᱗','᱘','᱙' },
	tamldec = { '௦','௧','௨','௩','௪','௫','௬','௭','௮','௯' },
	tibt = { '༠','༡','༢','༣','༤','༥','༦','༧','༨','༩' },
	thai = { '๐','๑','๒','๓','๔','๕','๖','๗','๘','๙' },
};

local substitute_chars = { };
for ns, tbl in pairs(numbering_system) do
	if ns ~= "latn" then
		substitute_chars[ns] = function(d)
			return tbl[d + 1];
		end;
	end;
	table.insert(valid_value_property.numberingSystem, ns);
end;
local function substitute(str, nu)
	if substitute_chars[nu] then
		return (str:gsub('%d', substitute_chars[nu]));
	end;
	return str;
end;

local function check_property(tbl_out, tbl_to_check, property, default)
	local check_values = valid_value_property[property];
	if not check_values then
		return;
	end;
	
	local value = rawget(tbl_to_check, property);
	if property == 'useGrouping' and type(value) == "boolean" then
		tbl_out[property] = value and default or "never";
		return;
	end;
	local valid = false;
	if type(check_values) == "table" then
		valid = table.find(check_values, value);
	elseif check_values == 'f/bool' then
		valid = (type(value) == "boolean");
	elseif check_values == 'f/str' then
		valid = (type(value) == "string");
	elseif check_values == 'f/table' then
		valid = (type(value) == "table");
	elseif not check_values then
		valid = true;
	elseif type(value) == "number" and (value % 1 == 0) or (value == math.huge) then
		local min, max = check_values:match("f/(%w*)%.%.(%w*)");
		valid = (value >= (tbl_out[min] or tonumber(min) or 0)) and ((max == '' and value ~= math.huge) or (value <= tonumber(max)));
	end;
	if valid then
		tbl_out[property] = value;
		return;
	elseif value == nil then
		if type(default) == "string" and (default:sub(1, 7) == 'error: ') then
			error(default:sub(8), 4);
		end;
		tbl_out[property] = default;
		return;
	end;
	error(property .. " value is out of range.", 4);
end;
local function check_options(range, parts, notation, options)
	local ret = { };
	if type(options) ~= "table" then
		options = { };
	end;
	check_property(ret, options, 'groupSymbol', ',');
	check_property(ret, options, 'decimalSymbol', '.');
	check_property(ret, options, 'useGrouping', notation == "compact" and "min2" or "always");
	check_property(ret, options, 'style', 'decimal');
	if notation == "compact" then
		check_property(ret, options, 'compactPattern', defaultCompactPattern);
		check_property(ret, options, 'minimumSignificantDigitsToKeep', 2);
		check_property(ret, options, 'trailingZeroesIfRounded', 0);
		
		check_property(ret, options, 'compactFallback', 'last');
	end
	if notation == "scientific" or options.compactFallback == "scientific" then
		check_property(ret, options, 'engineering', false);
		check_property(ret, options, 'exponentLowercased', false);
	end;
	
	if ret.style == "currency" then
		check_property(ret, options, 'currency', 'error: Currency is required with currency style');
	elseif ret.style == "unit" then
		error("The 'unit' style option isn't supported", 3);
	end;
	
	check_property(ret, options, 'rounding', notation == "compact" and "down" or "halfEven");
	ret.isSignificant = not not (rawget(options, 'minimumSignificantDigits') or rawget(options, 'maximumSignificantDigits'));
	if ret.isSignificant then
		check_property(ret, options, 'minimumSignificantDigits', 1);
		check_property(ret, options, 'maximumSignificantDigits');
	else
		check_property(ret, options, 'minimumIntegerDigits', 1);
		check_property(ret, options, 'maximumIntegerDigits');
		check_property(ret, options, 'minimumFractionDigits');
		check_property(ret, options, 'maximumFractionDigits');
		
		if not (ret.minimumFractionDigits or ret.maximumFractionDigits) then
			if ret.style == "percent" then
				ret.minimumFractionDigits = 0;
				ret.maximumFractionDigits = 0;
			elseif notation ~= "compact" then
				ret.minimumFractionDigits = 0;
				ret.maximumFractionDigits = 3;
			end;
		end;
	end;
	if range then
		check_property(ret, options, 'rangeIdentityFallback', 'singleValue');
		check_property(ret, options, 'rangeCollapse', 'none');
	end;
	check_property(ret, options, 'numberingSystem', 'latn');
	return ret;
end;

local spaces = { utf8.char(0x0020), utf8.char(0x00A0), utf8.char(0x1680), utf8.char(0x180E), utf8.char(0x2000), utf8.char(0x2001), utf8.char(0x2002), utf8.char(0x2003), 
	utf8.char(0x2004), utf8.char(0x2005), utf8.char(0x2006), utf8.char(0x2007), utf8.char(0x2008), utf8.char(0x2009), utf8.char(0x200A), utf8.char(0x200B), utf8.char(0x202F), utf8.char(0x205F), utf8.char(0x3000), utf8.char(0xFEFF) };

local function spacestoparts(value)
	local left, right;
	for _, v in ipairs(spaces) do
		if value:sub(1, #v) == v then
			left, value = v, value:sub(#v + 1);
		end;
		if value:sub(-#v) == v then
			value, right = value:sub(1, -(#v + 1)), v;
		end;
	end;
	return left, value, right;
end;

local function quantize(val, exp, rounding)
	local d, e = ('0' .. val):gsub('%.', ''), (val:find('%.') or (#val + 1)) + 1;
	local pos = e + exp;
	if pos > #d then
		return val:match("^(%d*)%.?(%d*)$");
	end;
	d = d:split('');
	local add = rounding == 'up';
	if rounding ~= "up" and rounding ~= "down" then
		add = d[pos]:match(((rounding == "halfEven" and (d[pos - 1] or '0'):match('[02468]')) or rounding == "halfDown") and '[6-9]' or '[5-9]');
	end;
	for p = pos, #d do
		d[p] = 0
	end;
	if add then
		repeat
			if d[pos] == 10 then
				d[pos] = 0;
			end;
			pos = pos - 1;
			d[pos] = tonumber(d[pos]) + 1;
		until d[pos] ~= 10;
	end;
	return table.concat(d, '', 1, e - 1), table.concat(d, '', e);
end;
local function scale(val, exp)
	val = ('0'):rep(-exp) .. val .. ('0'):rep(exp);
	local unscaled = (val:gsub("[.,]", ''));
	local len = #val;
	local dpos = (val:find("[.,]") or (len + 1)) + exp;
	return unscaled:sub(1, dpos - 1) .. '.' .. unscaled:sub(dpos);
end;
local function compact(val, size)
	val = (val:gsub('%.', ''));
	return val:sub(1, size) .. '.' .. val:sub(size + 1);
end;
local function exp(val, engineering)
	local negt, intg, frac = val:match('(-?)(%d*)%.?(%d*)');
	intg = intg:gsub('^0+', '');
	if #intg == 0 and frac:gsub('0+$', '') ~= '' then
		local fsize = (frac:find('[^0]') or (#frac + 1)) - 1;
		local size = engineering and (3 - (fsize % 3)) or 1;
		return negt .. (frac:sub(fsize + 1, fsize + size) .. ('0'):rep(math.max((fsize + size) - #frac, 0))) 
		.. ('.' .. frac:sub(fsize + size + 1)):gsub('%.0*$', '') .. ('E-' .. fsize + size):gsub('-0+$', '0');
	end;
	local size = engineering and (((#intg - 1) % 3) + 1) or 1;
	return negt .. (('0'):rep(math.max(size - #intg, 0)) .. intg:sub(1, size)) .. ('.' .. intg:sub(size + 1) .. frac):gsub('%.0*$', '') .. 'E' .. math.max(#intg - size, 0);
end;
local function raw_format(val, minintg, maxintg, minfrac, maxfrac, rounding)
	local intg, frac;
	if maxfrac and maxfrac ~= math.huge then
		intg, frac = quantize(val, maxfrac, rounding);
	else
		intg, frac = val:match("^(%d*)%.?(%d*)$");
	end;
	intg = intg:gsub('^0+', '');
	frac = frac:gsub('0+$', '');
	local intglen = #intg;
	local fraclen = #frac;
	if minintg and (intglen < minintg) then
		intg = ('0'):rep(minintg - intglen) .. intg;
	end;
	if minfrac and (fraclen < minfrac) then
		frac = frac .. ('0'):rep(minfrac - fraclen);
	end;
	if maxintg and (intglen > maxintg) then
		intg = intg:sub(-maxintg);
	end;
	if frac == '' then
		return intg;
	end;
	return intg .. '.' .. frac;
end;
local function raw_format_sig(val, min, max, rounding)
	local intg, frac = val:match("^(%d*)%.?(%d*)$");
	intg, frac = intg:gsub('^0+', ''), frac:gsub('0+$', '');
	intg = intg == '' and '0' or intg;
	if max and max ~= math.huge then
		val = intg .. '.' .. frac;
		intg, frac = quantize(val, max - ((val:find('%.') or (#val + 1)) - 1) + #val:gsub('%.', ''):match("^0*"), rounding);
		intg, frac = intg:gsub('^0+', ''), frac:gsub('0+$', '');
		intg = intg == '' and '0' or intg;
	end;
	if min then
		min = math.max(min - #val:gsub('%.%d*$', ''), 0);
		if #frac < min then
			frac = frac .. ('0'):rep(min - #frac);
		end;
	end;
	if frac == '' then
		return intg;
	end;
	return intg .. '.' .. frac;
end;
local function parse_exp(val)
	if not val:find('[eE]') then
		return val;
	end;
	local negt, val, exp = val:match('^([+%-]?)(%d*%.?%d*)[eE]([+%-]?%d+)$');
	if val then
		exp = tonumber(exp);
		if not exp then
			return nil;
		end;
		if val == '' then
			return nil;
		end;
		return negt .. scale(val, exp);
	end;
	return nil;
end;
local function num_to_str(value)
	local value_type = type(value);
	if value_type == "number" then
		value = (value % 1 == 0 and '%.0f' or '%.17f'):format(value);
	else
		value = tostring(value);
		value = parse_exp(value) or value:lower();
	end;
	return value;
end;

local function format(hide, parts, notation, value, options)
	-- from International, modified
	local negt, post = value:match("^([+%-]?)(.+)$");
	local expt;
	local tokenized_compact;
	local curr = ((options.currency and (hide ~= 'unit' and hide ~= 'all') and (options.currency .. (options.currency:match("%a$") and ' ' or ''))) or '');
	if post:match("^[%d.]*$") and select(2, post:gsub('%.', '')) < 2 then
		if options.style == "percent" then
			post = scale(post, 2);
		end;
		local minfrac, maxfrac = options.minimumFractionDigits, options.maximumFractionDigits;
		if notation == "compact" then
			post = post:gsub('^0+', '');
			local intlen = #post:gsub('%..*', '') - 3;
			local compact_val = post;
			local pattern_len = #options.compactPattern;
			local csize;
			if options.compactFallback == "scientific" and intlen > pattern_len then
				return format('scientific', negt .. compact_val, options);
			elseif (options.compactPattern[options.compactFallback == "standard" and intlen or math.min(intlen, pattern_len)] or '0') ~= '0' then
				tokenized_compact, csize = generatecompact(options.compactPattern[math.min(intlen, pattern_len)]);
				csize += math.max(intlen - pattern_len, 0);
				compact_val = compact(post, csize);
			-- The '0' pattern indicates no compact number available
			end;
			if not (minfrac or maxfrac) then
				maxfrac = math.max(options.minimumSignificantDigitsToKeep - ((compact_val:find('%.') or (#compact_val + 1)) - 1) + #compact_val:gsub('%.', ''):match("^0*"), 0);
				minfrac = math.min(maxfrac, options.trailingZeroesIfRounded);
			end;
			
			local formatted_compact_val;
			if options.isSignificant then
				formatted_compact_val = raw_format_sig(compact_val, options.minimumSignificantDigits, options.maximumSignificantDigits, options.rounding);
			else
				formatted_compact_val = raw_format(compact_val, options.minimumIntegerDigits, options.maximumIntegerDigits, minfrac, maxfrac, options.rounding);
			end;
			
			-- Check if 9's are rounded through 10 via length, remove decimals
			if #formatted_compact_val:gsub("%.%d*$", ''):gsub('^0+', '') == #compact_val:gsub("%.%d*$", '') then
				post = formatted_compact_val;
			else
				compact_val = raw_format_sig(post, 0, options.maximumSignificantDigits or csize or #compact_val:gsub("%.%d*$", '') , options.rounding);
				intlen += 1;
				if options.compactFallback == "scientific" and intlen > pattern_len then
					return format('scientific', negt .. compact_val, options);
				elseif (options.compactPattern[options.compactFallback == "standard" and intlen or math.min(intlen, pattern_len)] or '0') ~= '0' then
					local size;
					tokenized_compact, size = generatecompact(options.compactPattern[math.min(intlen, pattern_len)]);
					size += math.max(intlen - pattern_len, 0);
					compact_val = compact(compact_val, size);
				end;
				if options.isSignificant then
					post = raw_format_sig(compact_val, options.minimumSignificantDigits, options.maximumSignificantDigits, options.rounding);
				else
					post = raw_format(compact_val, options.minimumIntegerDigits, options.maximumIntegerDigits, minfrac, maxfrac, options.rounding);
				end;
			end;
			if hide == 'notation' or hide == 'all' then
				if tokenized_compact[1] ~= 0 then
					error("prefixes for compact notation using range formatting when range collapse of 'all' isn't supported", 3);
				end;
				tokenized_compact = nil;
			end;
		elseif notation == "scientific" then
			post, expt = exp(post, options.engineering):match("^(%d*%.?%d*)E(-?%d*)$");
			
			if options.isSignificant then
				post = raw_format_sig(post, options.minimumSignificantDigits, options.maximumSignificantDigits, options.rounding);
			else
				post = raw_format(post, options.minimumIntegerDigits, options.maximumIntegerDigits, minfrac, maxfrac, options.rounding);
			end;
			if #post:gsub("%.%d*$", '') > (options.engineering and 3 or 1) then
				post = scale(post, options.engineering and -3 or -1);
				if options.isSignificant then
					post = raw_format_sig(post, options.minimumSignificantDigits, options.maximumSignificantDigits, options.rounding);
				else
					post = raw_format(post, options.minimumIntegerDigits, options.maximumIntegerDigits, minfrac, maxfrac, options.rounding);
				end;
				expt = tostring(expt + (options.engineering and 3 or 1));
			end;
			if hide == 'all' or hide == 'notation' then
				expt = nil;
			end;
		elseif options.isSignificant then
			post = raw_format_sig(post, options.minimumSignificantDigits, options.maximumSignificantDigits, options.rounding);
		else
			post = raw_format(post, options.minimumIntegerDigits, options.maximumIntegerDigits, minfrac, maxfrac, options.rounding);
		end;
	elseif (post == "inf") or (post == "infinity") then
		if parts then
			local ret = { { type = "infinity", value = '∞' } };
			if curr ~= '' then
				table.insert(ret, 1, { type = "currency", value = curr });
			end;
			if negt == '-' then
				table.insert(ret, 1, { type = "minusSign", value = negt });
			end;
			if options.style == "percent" then
				table.insert(ret, { type = "percent", value = '%' });
			end;
			return ret;
		end;
		return (negt == '-' and '-' or '') .. curr .. '∞' .. (options.style == "percent" and '%' or ''), 'Infinity';
	else
		if parts then
			local ret = { { type = "nan", value = 'NaN' } };
			if curr ~= '' then
				table.insert(ret, 1, { type = "currency", value = curr });
			end;
			if options.style == "percent" then
				table.insert(ret, { type = "percent", value = '%' });
			end;
			return ret;
		end;
		return curr .. 'NaN' .. (options.style == "percent" and '%' or ''), 'NaN';
	end;
	negt = negt == '-';
	local ret = parts and { };
	
	local first, intg, frac = post:match("^(%d)(%d*)%.?(%d*)$");
	if (options.useGrouping ~= "never") and (#intg > (options.useGrouping == "min2" and 3 or 2)) then
		if parts then
			for r in intg:reverse():gmatch('%d%d?%d?') do
				table.insert(ret, 1, { type = "integer", value = substitute(r:reverse(), options.numberingSystem) });
				table.insert(ret, 1, { type = "group", value = options.groupSymbol });
			end;
			if #ret[2].value == 3 then
				table.insert(ret, 1, { type = "integer", value = substitute(first, options.numberingSystem) });
			else
				table.remove(ret, 1);
				ret[1].value = substitute(first, options.numberingSystem) .. ret[1].value;
			end;
		else
			intg = substitute(intg:reverse():gsub("%d%d%d", "%1" .. options.groupSymbol:reverse()):reverse(), options.numberingSystem);
		end;
	elseif parts then
		table.insert(ret, { type = "integer", value = first .. intg });
	end;
	if ret then
		if curr ~= '' then
			table.insert(ret, 1, { type = "currency", value = curr });
		end;
		if negt then
			table.insert(ret, 1, { type = "minusSign", value = negt });
		end;
		if frac ~= '' then
			table.insert(ret, { type = "decimal", value = options.decimalSymbol });
			table.insert(ret, { type = "fraction", value = frac });
		end;
		if expt then
			table.insert(ret, { type = "exponentSeparator", value = options.exponentLowercased and 'e' or 'E' });
			table.insert(ret, { type = "exponentInteger", value = expt });
		end;
		if options.style == "percent" and not tokenized_compact then
			table.insert(ret, { type = "percentSign", value = '%' });
		end;
		if tokenized_compact then
			if #tokenized_compact == 3 then
				local prefix, value, suffix = spacestoparts(tokenized_compact[3]);
				if prefix then
					table.insert(ret, { type = "literal", value = prefix });
				end;
				table.insert(ret, { type = "compact", value = value });
				if suffix then
					table.insert(ret, { type = "literal", value = suffix });
				end;
				prefix, value, suffix = spacestoparts(tokenized_compact[1]);
				if prefix then
					table.insert(ret, 1, { type = "literal", value = suffix });
				end;
				table.insert(ret, 1, { type = "compact", value = value });
				if suffix then
					table.insert(ret, 1, { type = "literal", value = prefix });
				end;
			elseif tokenized_compact[1] == 0 then
				local prefix, value, suffix = spacestoparts(tokenized_compact[2]);
				if prefix then
					table.insert(ret, { type = "literal", value = prefix });
				end;
				table.insert(ret, { type = "compact", value = value });
				if suffix then
					table.insert(ret, { type = "literal", value = suffix });
				end;
			else
				local prefix, value, suffix = spacestoparts(tokenized_compact[1]);
				if prefix then
					table.insert(ret, 1, { type = "literal", value = suffix });
				end;
				table.insert(ret, 1, { type = "compact", value = value });
				if suffix then
					table.insert(ret, 1, { type = "literal", value = prefix });
				end;
			end;
		end;
	else
		ret = table.concat {
			negt and '-' or '',
			curr,
			substitute(first, options.numberingSystem),
			intg,
			frac == '' and '' or options.decimalSymbol,
			frac,
			expt and (options.exponentLowercased and 'e' or 'E') or '',
			expt and substitute(expt, options.numberingSystem) or '',
			(options.style == "percent" and hide ~= "unit" and hide ~= "all" and not tokenized_compact) and '%' or '',
		};
		if tokenized_compact then
			local value_pos = table.find(tokenized_compact, 0);
			if value_pos then
				tokenized_compact[value_pos] = ret;
			end;
			return table.concat(tokenized_compact), post;
		end;
	end;
	return ret, post;
end;

----
function f.FormatStandard(...)
	if select('#', ...) == 0 then
		error("missing argument #1", 2);
	end;
	local value, options = ...;
	return (format('none', false, 'standard', num_to_str(value), check_options(false, false, 'standard', options)));
end;

function f.FormatCompact(...)
	if select('#', ...) == 0 then
		error("missing argument #1", 2);
	end;
	local value, options = ...;
	return (format('none', false, 'compact', num_to_str(value), check_options(false, false, 'compact', options)));
end;

function f.FormatScientific(...)
	if select('#', ...) == 0 then
		error("missing argument #1", 2);
	end;
	local value, options = ...;
	return (format('none', false, 'scientific', num_to_str(value), check_options(false, false, 'scientific', options)));
end;

-- Range --
local function format_range(options, value0, value1, formatted0, formatted1, rvalue0, rvalue1)
	local eq = (rvalue0 ~= 'NaN' and rvalue1 ~= 'NaN') and ((value0 == value1 and "equalBeforeRounding") or (rvalue0 == rvalue1 and "equalAfterRounding")) or "notEqual";
	if eq ~= "notEqual" and options.rangeIdentityFallback ~= "range" then
		if options.rangeIdentityFallback == "singleValue" or (options.rangeIdentityFallback == "approximatelyOrSingleValue" and eq == "equalBeforeRounding") then
			return formatted1, eq;
		end;
		return '~' .. formatted1, eq;
	end;
	return ("%s–%s"):format(formatted0, formatted1), eq;
end;

function f.FormatStandardRange(...)
	local len = select('#', ...);
	if len < 2 then
		error("missing argument #" .. (len + 1), 2);
	end;
	local value0, value1, options = ...;
	value0, value1 = num_to_str(value0), num_to_str(value1);
	options = check_options(true, false, 'standard', options);
	local formatted0, rvalue0 = format(options.style == "currency" and options.rangeCollapse or 'none', false, 'standard', value0, options);
	local formatted1, rvalue1 = format(options.style == "percent" and options.rangeCollapse or 'none', false, 'standard', value1, options);
	return format_range(options, value0, value1, formatted0, formatted1, rvalue0, rvalue1);
end;

function f.FormatCompactRange(...)
	local len = select('#', ...);
	if len < 2 then
		error("missing argument #" .. (len + 1), 2);
	end;
	local value0, value1, options = ...;
	value0, value1 = num_to_str(value0), num_to_str(value1);
	options = check_options(true, false, 'compact', options);
	local formatted0, rvalue0 = format(options.style == "currency" and options.rangeCollapse or (options.rangeCollapse == 'all' and 'notation') or 'none', false, 'compact', value0, options);
	local formatted1, rvalue1 = format(options.style == "percent" and 'unit' or 'none', false, 'compact', value1, options);
	return (format_range(options, value0, value1, formatted0, formatted1, rvalue0, rvalue1));
end;

function f.FormatScientificRange(...)
	local len = select('#', ...);
	if len < 2 then
		error("missing argument #" .. (len + 1), 2);
	end;
	local value0, value1, options = ...;
	options = check_options(true, false, 'scientific', options);
	local formatted0, rvalue0 = format(options.style == "currency" and options.rangeCollapse or (options.rangeCollapse == 'all' and 'notation') or 'none', false, 'scientific', value0, options);
	local formatted1, rvalue1 = format('none', false, 'scientific', value1, options);
	return format_range(options, value0, value1, formatted0, formatted1, rvalue0, rvalue1);
end;

-- Parts --
function f.FormatStandardToParts(...)
	if select('#', ...) == 0 then
		error("missing argument #1", 2);
	end;
	local value, options = ...;
	return (format('none', true, 'standard', num_to_str(value), check_options(false, true, 'standard', options)));
end;

function f.FormatCompactToParts(...)
	if select('#', ...) == 0 then
		error("missing argument #1", 2);
	end;
	local value, options = ...;
	return (format('none', true, 'compact', num_to_str(value), check_options(false, true, 'compact', options)));
end;

function f.FormatScientificToParts(...)
	if select('#', ...) == 0 then
		error("missing argument #1", 2);
	end;
	local value, options = ...;
	return (format('none', true, 'scientific', num_to_str(value), check_options(false, true, 'scientific', options)));
end;


return setmetatable({ }, { __metatable = "The metatable is locked", __index = f,
	__newindex = function()
		error("Attempt to modify a readonly table", 2);
	end,
});