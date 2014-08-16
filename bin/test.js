(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var EReg = function() { };
EReg.__name__ = ["EReg"];
EReg.prototype = {
	r: null
	,match: function(s) {
		if(this.r.global) this.r.lastIndex = 0;
		this.r.m = this.r.exec(s);
		this.r.s = s;
		return this.r.m != null;
	}
	,__class__: EReg
};
var HxOverrides = function() { };
HxOverrides.__name__ = ["HxOverrides"];
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) return undefined;
	return x;
};
HxOverrides.substr = function(s,pos,len) {
	if(pos != null && pos != 0 && len != null && len < 0) return "";
	if(len == null) len = s.length;
	if(pos < 0) {
		pos = s.length + pos;
		if(pos < 0) pos = 0;
	} else if(len < 0) len = s.length + len - pos;
	return s.substr(pos,len);
};
HxOverrides.indexOf = function(a,obj,i) {
	var len = a.length;
	if(i < 0) {
		i += len;
		if(i < 0) i = 0;
	}
	while(i < len) {
		if(a[i] === obj) return i;
		i++;
	}
	return -1;
};
HxOverrides.remove = function(a,obj) {
	var i = HxOverrides.indexOf(a,obj,0);
	if(i == -1) return false;
	a.splice(i,1);
	return true;
};
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var Lambda = function() { };
Lambda.__name__ = ["Lambda"];
Lambda.array = function(it) {
	var a = new Array();
	var $it0 = $iterator(it)();
	while( $it0.hasNext() ) {
		var i = $it0.next();
		a.push(i);
	}
	return a;
};
Lambda.has = function(it,elt) {
	var $it0 = $iterator(it)();
	while( $it0.hasNext() ) {
		var x = $it0.next();
		if(x == elt) return true;
	}
	return false;
};
var List = function() {
	this.length = 0;
};
List.__name__ = ["List"];
List.prototype = {
	h: null
	,q: null
	,length: null
	,add: function(item) {
		var x = [item];
		if(this.h == null) this.h = x; else this.q[1] = x;
		this.q = x;
		this.length++;
	}
	,remove: function(v) {
		var prev = null;
		var l = this.h;
		while(l != null) {
			if(l[0] == v) {
				if(prev == null) this.h = l[1]; else prev[1] = l[1];
				if(this.q == l) this.q = prev;
				this.length--;
				return true;
			}
			prev = l;
			l = l[1];
		}
		return false;
	}
	,iterator: function() {
		return { h : this.h, hasNext : function() {
			return this.h != null;
		}, next : function() {
			if(this.h == null) return null;
			var x = this.h[0];
			this.h = this.h[1];
			return x;
		}};
	}
	,__class__: List
};
var IMap = function() { };
IMap.__name__ = ["IMap"];
Math.__name__ = ["Math"];
var Reflect = function() { };
Reflect.__name__ = ["Reflect"];
Reflect.field = function(o,field) {
	try {
		return o[field];
	} catch( e ) {
		return null;
	}
};
Reflect.callMethod = function(o,func,args) {
	return func.apply(o,args);
};
Reflect.fields = function(o) {
	var a = [];
	if(o != null) {
		var hasOwnProperty = Object.prototype.hasOwnProperty;
		for( var f in o ) {
		if(f != "__id__" && f != "hx__closures__" && hasOwnProperty.call(o,f)) a.push(f);
		}
	}
	return a;
};
Reflect.isFunction = function(f) {
	return typeof(f) == "function" && !(f.__name__ || f.__ename__);
};
Reflect.compare = function(a,b) {
	if(a == b) return 0; else if(a > b) return 1; else return -1;
};
Reflect.compareMethods = function(f1,f2) {
	if(f1 == f2) return true;
	if(!Reflect.isFunction(f1) || !Reflect.isFunction(f2)) return false;
	return f1.scope == f2.scope && f1.method == f2.method && f1.method != null;
};
Reflect.isObject = function(v) {
	if(v == null) return false;
	var t = typeof(v);
	return t == "string" || t == "object" && v.__enum__ == null || t == "function" && (v.__name__ || v.__ename__) != null;
};
var Std = function() { };
Std.__name__ = ["Std"];
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
var StringBuf = function() {
	this.b = "";
};
StringBuf.__name__ = ["StringBuf"];
StringBuf.prototype = {
	b: null
	,add: function(x) {
		this.b += Std.string(x);
	}
	,__class__: StringBuf
};
var StringTools = function() { };
StringTools.__name__ = ["StringTools"];
StringTools.htmlEscape = function(s,quotes) {
	s = s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
	if(quotes) return s.split("\"").join("&quot;").split("'").join("&#039;"); else return s;
};
StringTools.startsWith = function(s,start) {
	return s.length >= start.length && HxOverrides.substr(s,0,start.length) == start;
};
StringTools.isSpace = function(s,pos) {
	var c = HxOverrides.cca(s,pos);
	return c > 8 && c < 14 || c == 32;
};
StringTools.ltrim = function(s) {
	var l = s.length;
	var r = 0;
	while(r < l && StringTools.isSpace(s,r)) r++;
	if(r > 0) return HxOverrides.substr(s,r,l - r); else return s;
};
StringTools.rtrim = function(s) {
	var l = s.length;
	var r = 0;
	while(r < l && StringTools.isSpace(s,l - r - 1)) r++;
	if(r > 0) return HxOverrides.substr(s,0,l - r); else return s;
};
StringTools.trim = function(s) {
	return StringTools.ltrim(StringTools.rtrim(s));
};
StringTools.replace = function(s,sub,by) {
	return s.split(sub).join(by);
};
var TestAll = function() {
};
TestAll.__name__ = ["TestAll"];
TestAll.main = function() {
	var runner = new utest_Runner();
	runner.addCase(new TestAll());
	runner.addCase(new thx_geom_TestEdge());
	runner.addCase(new thx_geom_TestLine());
	runner.addCase(new thx_geom_TestPoint());
	runner.addCase(new thx_geom_TestPoint3D());
	runner.addCase(new thx_geom_TestSpline());
	utest_ui_Report.create(runner);
	runner.run();
};
TestAll.prototype = {
	__class__: TestAll
};
var ValueType = { __ename__ : ["ValueType"], __constructs__ : ["TNull","TInt","TFloat","TBool","TObject","TFunction","TClass","TEnum","TUnknown"] };
ValueType.TNull = ["TNull",0];
ValueType.TNull.__enum__ = ValueType;
ValueType.TInt = ["TInt",1];
ValueType.TInt.__enum__ = ValueType;
ValueType.TFloat = ["TFloat",2];
ValueType.TFloat.__enum__ = ValueType;
ValueType.TBool = ["TBool",3];
ValueType.TBool.__enum__ = ValueType;
ValueType.TObject = ["TObject",4];
ValueType.TObject.__enum__ = ValueType;
ValueType.TFunction = ["TFunction",5];
ValueType.TFunction.__enum__ = ValueType;
ValueType.TClass = function(c) { var $x = ["TClass",6,c]; $x.__enum__ = ValueType; return $x; };
ValueType.TEnum = function(e) { var $x = ["TEnum",7,e]; $x.__enum__ = ValueType; return $x; };
ValueType.TUnknown = ["TUnknown",8];
ValueType.TUnknown.__enum__ = ValueType;
var Type = function() { };
Type.__name__ = ["Type"];
Type.getClass = function(o) {
	if(o == null) return null;
	if((o instanceof Array) && o.__enum__ == null) return Array; else return o.__class__;
};
Type.getEnum = function(o) {
	if(o == null) return null;
	return o.__enum__;
};
Type.getClassName = function(c) {
	var a = c.__name__;
	return a.join(".");
};
Type.getEnumName = function(e) {
	var a = e.__ename__;
	return a.join(".");
};
Type.getInstanceFields = function(c) {
	var a = [];
	for(var i in c.prototype) a.push(i);
	HxOverrides.remove(a,"__class__");
	HxOverrides.remove(a,"__properties__");
	return a;
};
Type["typeof"] = function(v) {
	var _g = typeof(v);
	switch(_g) {
	case "boolean":
		return ValueType.TBool;
	case "string":
		return ValueType.TClass(String);
	case "number":
		if(Math.ceil(v) == v % 2147483648.0) return ValueType.TInt;
		return ValueType.TFloat;
	case "object":
		if(v == null) return ValueType.TNull;
		var e = v.__enum__;
		if(e != null) return ValueType.TEnum(e);
		var c;
		if((v instanceof Array) && v.__enum__ == null) c = Array; else c = v.__class__;
		if(c != null) return ValueType.TClass(c);
		return ValueType.TObject;
	case "function":
		if(v.__name__ || v.__ename__) return ValueType.TObject;
		return ValueType.TFunction;
	case "undefined":
		return ValueType.TNull;
	default:
		return ValueType.TUnknown;
	}
};
Type.enumConstructor = function(e) {
	return e[0];
};
Type.enumParameters = function(e) {
	return e.slice(2);
};
Type.enumIndex = function(e) {
	return e[1];
};
var haxe_StackItem = { __ename__ : ["haxe","StackItem"], __constructs__ : ["CFunction","Module","FilePos","Method","LocalFunction"] };
haxe_StackItem.CFunction = ["CFunction",0];
haxe_StackItem.CFunction.__enum__ = haxe_StackItem;
haxe_StackItem.Module = function(m) { var $x = ["Module",1,m]; $x.__enum__ = haxe_StackItem; return $x; };
haxe_StackItem.FilePos = function(s,file,line) { var $x = ["FilePos",2,s,file,line]; $x.__enum__ = haxe_StackItem; return $x; };
haxe_StackItem.Method = function(classname,method) { var $x = ["Method",3,classname,method]; $x.__enum__ = haxe_StackItem; return $x; };
haxe_StackItem.LocalFunction = function(v) { var $x = ["LocalFunction",4,v]; $x.__enum__ = haxe_StackItem; return $x; };
var haxe_CallStack = function() { };
haxe_CallStack.__name__ = ["haxe","CallStack"];
haxe_CallStack.callStack = function() {
	var oldValue = Error.prepareStackTrace;
	Error.prepareStackTrace = function(error,callsites) {
		var stack = [];
		var _g = 0;
		while(_g < callsites.length) {
			var site = callsites[_g];
			++_g;
			var method = null;
			var fullName = site.getFunctionName();
			if(fullName != null) {
				var idx = fullName.lastIndexOf(".");
				if(idx >= 0) {
					var className = HxOverrides.substr(fullName,0,idx);
					var methodName = HxOverrides.substr(fullName,idx + 1,null);
					method = haxe_StackItem.Method(className,methodName);
				}
			}
			stack.push(haxe_StackItem.FilePos(method,site.getFileName(),site.getLineNumber()));
		}
		return stack;
	};
	var a = haxe_CallStack.makeStack(new Error().stack);
	a.shift();
	Error.prepareStackTrace = oldValue;
	return a;
};
haxe_CallStack.exceptionStack = function() {
	return [];
};
haxe_CallStack.toString = function(stack) {
	var b = new StringBuf();
	var _g = 0;
	while(_g < stack.length) {
		var s = stack[_g];
		++_g;
		b.b += "\nCalled from ";
		haxe_CallStack.itemToString(b,s);
	}
	return b.b;
};
haxe_CallStack.itemToString = function(b,s) {
	switch(s[1]) {
	case 0:
		b.b += "a C function";
		break;
	case 1:
		var m = s[2];
		b.b += "module ";
		if(m == null) b.b += "null"; else b.b += "" + m;
		break;
	case 2:
		var line = s[4];
		var file = s[3];
		var s1 = s[2];
		if(s1 != null) {
			haxe_CallStack.itemToString(b,s1);
			b.b += " (";
		}
		if(file == null) b.b += "null"; else b.b += "" + file;
		b.b += " line ";
		if(line == null) b.b += "null"; else b.b += "" + line;
		if(s1 != null) b.b += ")";
		break;
	case 3:
		var meth = s[3];
		var cname = s[2];
		if(cname == null) b.b += "null"; else b.b += "" + cname;
		b.b += ".";
		if(meth == null) b.b += "null"; else b.b += "" + meth;
		break;
	case 4:
		var n = s[2];
		b.b += "local function #";
		if(n == null) b.b += "null"; else b.b += "" + n;
		break;
	}
};
haxe_CallStack.makeStack = function(s) {
	if(typeof(s) == "string") {
		var stack = s.split("\n");
		var m = [];
		var _g = 0;
		while(_g < stack.length) {
			var line = stack[_g];
			++_g;
			m.push(haxe_StackItem.Module(line));
		}
		return m;
	} else return s;
};
var haxe_Log = function() { };
haxe_Log.__name__ = ["haxe","Log"];
haxe_Log.trace = function(v,infos) {
	js_Boot.__trace(v,infos);
};
var haxe_Timer = function(time_ms) {
	var me = this;
	this.id = setInterval(function() {
		me.run();
	},time_ms);
};
haxe_Timer.__name__ = ["haxe","Timer"];
haxe_Timer.delay = function(f,time_ms) {
	var t = new haxe_Timer(time_ms);
	t.run = function() {
		t.stop();
		f();
	};
	return t;
};
haxe_Timer.stamp = function() {
	return new Date().getTime() / 1000;
};
haxe_Timer.prototype = {
	id: null
	,stop: function() {
		if(this.id == null) return;
		clearInterval(this.id);
		this.id = null;
	}
	,run: function() {
	}
	,__class__: haxe_Timer
};
var haxe_ds_IntMap = function() { };
haxe_ds_IntMap.__name__ = ["haxe","ds","IntMap"];
haxe_ds_IntMap.__interfaces__ = [IMap];
var haxe_ds_StringMap = function() {
	this.h = { };
};
haxe_ds_StringMap.__name__ = ["haxe","ds","StringMap"];
haxe_ds_StringMap.__interfaces__ = [IMap];
haxe_ds_StringMap.prototype = {
	h: null
	,set: function(key,value) {
		this.h["$" + key] = value;
	}
	,get: function(key) {
		return this.h["$" + key];
	}
	,exists: function(key) {
		return this.h.hasOwnProperty("$" + key);
	}
	,keys: function() {
		var a = [];
		for( var key in this.h ) {
		if(this.h.hasOwnProperty(key)) a.push(key.substr(1));
		}
		return HxOverrides.iter(a);
	}
	,__class__: haxe_ds_StringMap
};
var haxe_io_Bytes = function() { };
haxe_io_Bytes.__name__ = ["haxe","io","Bytes"];
haxe_io_Bytes.prototype = {
	length: null
	,b: null
	,__class__: haxe_io_Bytes
};
var haxe_io_Eof = function() { };
haxe_io_Eof.__name__ = ["haxe","io","Eof"];
haxe_io_Eof.prototype = {
	toString: function() {
		return "Eof";
	}
	,__class__: haxe_io_Eof
};
var js_Boot = function() { };
js_Boot.__name__ = ["js","Boot"];
js_Boot.__unhtml = function(s) {
	return s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
};
js_Boot.__trace = function(v,i) {
	var msg;
	if(i != null) msg = i.fileName + ":" + i.lineNumber + ": "; else msg = "";
	msg += js_Boot.__string_rec(v,"");
	if(i != null && i.customParams != null) {
		var _g = 0;
		var _g1 = i.customParams;
		while(_g < _g1.length) {
			var v1 = _g1[_g];
			++_g;
			msg += "," + js_Boot.__string_rec(v1,"");
		}
	}
	var d;
	if(typeof(document) != "undefined" && (d = document.getElementById("haxe:trace")) != null) d.innerHTML += js_Boot.__unhtml(msg) + "<br/>"; else if(typeof console != "undefined" && console.log != null) console.log(msg);
};
js_Boot.getClass = function(o) {
	if((o instanceof Array) && o.__enum__ == null) return Array; else return o.__class__;
};
js_Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) str += "," + js_Boot.__string_rec(o[i],s); else str += js_Boot.__string_rec(o[i],s);
				}
				return str + ")";
			}
			var l = o.length;
			var i1;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js_Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str2 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str2.length != 2) str2 += ", \n";
		str2 += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str2 += "\n" + s + "}";
		return str2;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
js_Boot.__interfLoop = function(cc,cl) {
	if(cc == null) return false;
	if(cc == cl) return true;
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0;
		var _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js_Boot.__interfLoop(i1,cl)) return true;
		}
	}
	return js_Boot.__interfLoop(cc.__super__,cl);
};
js_Boot.__instanceof = function(o,cl) {
	if(cl == null) return false;
	switch(cl) {
	case Int:
		return (o|0) === o;
	case Float:
		return typeof(o) == "number";
	case Bool:
		return typeof(o) == "boolean";
	case String:
		return typeof(o) == "string";
	case Array:
		return (o instanceof Array) && o.__enum__ == null;
	case Dynamic:
		return true;
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(o instanceof cl) return true;
				if(js_Boot.__interfLoop(js_Boot.getClass(o),cl)) return true;
			}
		} else return false;
		if(cl == Class && o.__name__ != null) return true;
		if(cl == Enum && o.__ename__ != null) return true;
		return o.__enum__ == cl;
	}
};
var thx_core_Iterators = function() { };
thx_core_Iterators.__name__ = ["thx","core","Iterators"];
thx_core_Iterators.map = function(it,f) {
	var acc = [];
	while( it.hasNext() ) {
		var v = it.next();
		acc.push(f(v));
	}
	return acc;
};
thx_core_Iterators.mapi = function(it,f) {
	var acc = [];
	var i = 0;
	while( it.hasNext() ) {
		var v = it.next();
		acc.push(f(v,i++));
	}
	return acc;
};
thx_core_Iterators.toArray = function(it) {
	var items = [];
	while( it.hasNext() ) {
		var item = it.next();
		items.push(item);
	}
	return items;
};
thx_core_Iterators.order = function(it,sort) {
	var n = thx_core_Iterators.toArray(it);
	n.sort(sort);
	return n;
};
thx_core_Iterators.reduce = function(it,callback,initial) {
	thx_core_Iterators.map(it,function(v) {
		initial = callback(initial,v);
	});
	return initial;
};
thx_core_Iterators.reducei = function(it,callback,initial) {
	thx_core_Iterators.mapi(it,function(v,i) {
		initial = callback(initial,v,i);
	});
	return initial;
};
thx_core_Iterators.isEmpty = function(it) {
	return !it.hasNext();
};
thx_core_Iterators.filter = function(it,predicate) {
	return thx_core_Iterators.reduce(it,function(acc,item) {
		if(predicate(item)) acc.push(item);
		return acc;
	},[]);
};
var thx_geom_Const = function() { };
thx_geom_Const.__name__ = ["thx","geom","Const"];
var thx_geom_Edge = function(vertex0,vertex1) {
	this.vertex0 = vertex0;
	this.vertex1 = vertex1;
};
thx_geom_Edge.__name__ = ["thx","geom","Edge"];
thx_geom_Edge.prototype = {
	vertex0: null
	,vertex1: null
	,area: null
	,length: null
	,lengthSquared: null
	,isLinear: null
	,intersects: function(other) {
		if(this.vertex0.equals(other.vertex1) || this.vertex1.equals(other.vertex0)) {
			if((function($this) {
				var $r;
				var this1;
				{
					var this2;
					var this3;
					var this4 = other.vertex1.position;
					var p = other.vertex0.position;
					var p_0 = -p[0];
					var p_1 = -p[1];
					this3 = [this4[0] + p_0,this4[1] + p_1];
					var v = Math.sqrt(this3[0] * this3[0] + this3[1] * this3[1]);
					this2 = [this3[0] / v,this3[1] / v];
					var p1;
					var this5;
					var this6 = $this.vertex1.position;
					var p2 = $this.vertex0.position;
					var p_01 = -p2[0];
					var p_11 = -p2[1];
					this5 = [this6[0] + p_01,this6[1] + p_11];
					var v1 = Math.sqrt(this5[0] * this5[0] + this5[1] * this5[1]);
					p1 = [this5[0] / v1,this5[1] / v1];
					this1 = [this2[0] + p1[0],this2[1] + p1[1]];
				}
				$r = Math.sqrt(this1[0] * this1[0] + this1[1] * this1[1]);
				return $r;
			}(this)) < 1e-5) return true;
		} else {
			var d0;
			var this7 = this.vertex1.position;
			var p3 = this.vertex0.position;
			var p_02 = -p3[0];
			var p_12 = -p3[1];
			d0 = [this7[0] + p_02,this7[1] + p_12];
			var d1;
			var this8 = other.vertex1.position;
			var p4 = other.vertex0.position;
			var p_03 = -p4[0];
			var p_13 = -p4[1];
			d1 = [this8[0] + p_03,this8[1] + p_13];
			if(Math.abs(d0[0] * d1[1] - d0[1] * d1[0]) < 1e-9) return false;
			var alphas = thx_geom__$Point_Point_$Impl_$.solve2Linear(-d0[0],d1[0],-d0[1],d1[1],this.vertex0.position[0] - other.vertex0.position[0],this.vertex0.position[1] - other.vertex0.position[1]);
			if(alphas[0] > 1e-6 && alphas[0] < 0.999999 && alphas[1] > 1e-5 && alphas[1] < 0.999999) return true;
		}
		return false;
	}
	,get_isLinear: function() {
		return thx_geom__$Point_Point_$Impl_$.isNearZero(this.vertex0.normal) && thx_geom__$Point_Point_$Impl_$.isNearZero(this.vertex1.normal);
	}
	,transform: function(matrix) {
		return new thx_geom_Edge(this.vertex0.transform(matrix),this.vertex1.transform(matrix));
	}
	,flip: function() {
		return new thx_geom_Edge(this.vertex1,this.vertex0);
	}
	,direction: function() {
		var this1 = this.vertex1.position;
		var p = this.vertex0.position;
		var p_0 = -p[0];
		var p_1 = -p[1];
		return [this1[0] + p_0,this1[1] + p_1];
	}
	,intersectionsWithEdge: function(other) {
		throw "not implemented";
	}
	,intersectionsWithLine: function(line) {
		throw "not implemented";
	}
	,at: function(distance) {
		throw "not implemented";
	}
	,interpolate: function(distance) {
		throw "not implemented";
	}
	,tangent: function(distance) {
		throw "not implemented";
	}
	,interpolateTangent: function(distance) {
		throw "not implemented";
	}
	,get_lengthSquared: function() {
		if(null == this.lengthSquared) {
			if(this.get_isLinear()) {
				var w = this.vertex1.position[0] - this.vertex0.position[0];
				var h = this.vertex1.position[1] - this.vertex0.position[1];
				this.lengthSquared = w * w + h * h;
			} else throw "not implemented";
		}
		return this.lengthSquared;
	}
	,get_area: function() {
		if(null == this.area) {
			if(this.get_isLinear()) {
				var p;
				var this1 = this.vertex1.position;
				var p1 = this.vertex0.position;
				var p_0 = -p1[0];
				var p_1 = -p1[1];
				p = [this1[0] + p_0,this1[1] + p_1];
				this.area = p[0] * p[1] / 2;
			} else throw "not implemented";
		}
		return this.area;
	}
	,get_length: function() {
		if(null == this.length) this.length = Math.sqrt(this.get_lengthSquared());
		return this.length;
	}
	,toString: function() {
		return "Edge (" + this.vertex0.toString() + " -> " + this.vertex1.toString() + ")";
	}
	,__class__: thx_geom_Edge
};
var thx_geom_Line = function(normal,w) {
	var l = Math.sqrt(normal[0] * normal[0] + normal[1] * normal[1]);
	this.w = w * l;
	this.normal = [normal[0] / l,normal[1] / l];
};
thx_geom_Line.__name__ = ["thx","geom","Line"];
thx_geom_Line.fromPoints = function(p1,p2) {
	var direction;
	var p_0 = -p1[0];
	var p_1 = -p1[1];
	direction = [p2[0] + p_0,p2[1] + p_1];
	var normal;
	var this1;
	var this_0 = direction[1];
	var this_1 = -direction[0];
	this1 = [-this_0,-this_1];
	var v = Math.sqrt(this1[0] * this1[0] + this1[1] * this1[1]);
	normal = [this1[0] / v,this1[1] / v];
	var w = p1[0] * normal[0] + p1[1] * normal[1];
	return new thx_geom_Line(normal,w);
};
thx_geom_Line.prototype = {
	normal: null
	,w: null
	,offset: function(value) {
		return new thx_geom_Line(this.normal,this.w + value);
	}
	,reverse: function() {
		return new thx_geom_Line((function($this) {
			var $r;
			var this1 = $this.normal;
			$r = [-this1[0],-this1[1]];
			return $r;
		}(this)),-this.w);
	}
	,equals: function(other) {
		return (function($this) {
			var $r;
			var this1 = $this.normal;
			var p = other.normal;
			$r = this1[0] == p[0] && this1[1] == p[1];
			return $r;
		}(this)) && this.w == other.w;
	}
	,origin: function() {
		var this1 = this.normal;
		var v = this.w;
		return [this1[0] * v,this1[1] * v];
	}
	,direction: function() {
		var this1 = this.normal;
		return [this1[1],-this1[0]];
	}
	,xAtY: function(y) {
		return (this.w - this.normal[1] * y) / this.normal[0];
	}
	,absDistanceToPoint: function(point) {
		return Math.abs((function($this) {
			var $r;
			var p = $this.normal;
			$r = point[0] * p[0] + point[1] * p[1];
			return $r;
		}(this)) - this.w);
	}
	,intersectWithLine: function(line) {
		return thx_geom__$Point_Point_$Impl_$.solve2Linear(this.normal[0],this.normal[1],line.normal[0],line.normal[1],this.w,line.w);
	}
	,transform: function(matrix) {
		var origin = [0,0];
		var pointOnPlane;
		var this1 = this.normal;
		var v = this.w;
		pointOnPlane = [this1[0] * v,this1[1] * v];
		var neworigin = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint(matrix,origin);
		var neworiginPlusNormal = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint(matrix,this.normal);
		var newnormal;
		var p_0 = -neworigin[0];
		var p_1 = -neworigin[1];
		newnormal = [neworiginPlusNormal[0] + p_0,neworiginPlusNormal[1] + p_1];
		var newpointOnPlane = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint(matrix,pointOnPlane);
		var neww = newnormal[0] * newpointOnPlane[0] + newnormal[1] * newpointOnPlane[1];
		return new thx_geom_Line(newnormal,neww);
	}
	,__class__: thx_geom_Line
};
var thx_geom_Line3D = function(point,direction) {
	this.point = point;
	var v = Math.sqrt(thx_geom__$Point3D_Point3D_$Impl_$.dot(direction,[direction[0],direction[1],direction[2]]));
	this.direction = [direction[0] / v,direction[1] / v,direction[2] / v];
};
thx_geom_Line3D.__name__ = ["thx","geom","Line3D"];
thx_geom_Line3D.fromPoints = function(p1,p2) {
	return new thx_geom_Line3D(p1,(function($this) {
		var $r;
		var this1;
		{
			var p_0 = -p1[0];
			var p_1 = -p1[1];
			var p_2 = -p1[2];
			this1 = [p2[0] + p_0,p2[1] + p_1,p2[2] + p_2];
		}
		var v = Math.sqrt(thx_geom__$Point3D_Point3D_$Impl_$.dot(this1,[this1[0],this1[1],this1[2]]));
		$r = [this1[0] / v,this1[1] / v,this1[2] / v];
		return $r;
	}(this)));
};
thx_geom_Line3D.fromPlanes = function(p1,p2) {
	var direction;
	var this1 = p1.normal;
	var p = p2.normal;
	direction = [this1[1] * p[2] - this1[2] * p[1],this1[2] * p[0] - this1[0] * p[2],this1[0] * p[1] - this1[1] * p[0]];
	var l = Math.sqrt(thx_geom__$Point3D_Point3D_$Impl_$.dot(direction,[direction[0],direction[1],direction[2]]));
	if(l < 1e-10) throw "Parallel planes";
	var v = 1.0 / l;
	direction = [direction[0] * v,direction[1] * v,direction[2] * v];
	var mabsx = Math.abs(direction[0]);
	var mabsy = Math.abs(direction[1]);
	var mabsz = Math.abs(direction[2]);
	var origin;
	if(mabsx >= mabsy && mabsx >= mabsz) {
		var r = thx_geom__$Point_Point_$Impl_$.solve2Linear(p1.normal[1],p1.normal[2],p2.normal[1],p2.normal[2],p1.w,p2.w);
		origin = [0,r[0],r[1]];
	} else if(mabsy >= mabsx && mabsy >= mabsz) {
		var r1 = thx_geom__$Point_Point_$Impl_$.solve2Linear(p1.normal[0],p1.normal[2],p2.normal[0],p2.normal[2],p1.w,p2.w);
		origin = [r1[0],0,r1[1]];
	} else {
		var r2 = thx_geom__$Point_Point_$Impl_$.solve2Linear(p1.normal[0],p1.normal[1],p2.normal[0],p2.normal[1],p1.w,p2.w);
		origin = [r2[0],r2[1],0];
	}
	return new thx_geom_Line3D(origin,direction);
};
thx_geom_Line3D.prototype = {
	point: null
	,direction: null
	,intersectWithPlane: function(plane) {
		var lambda = (plane.w - thx_geom__$Point3D_Point3D_$Impl_$.dot(plane.normal,this.point)) / thx_geom__$Point3D_Point3D_$Impl_$.dot(plane.normal,this.direction);
		var this1 = this.point;
		var p;
		var this2 = this.direction;
		p = [this2[0] * lambda,this2[1] * lambda,this2[2] * lambda];
		return [this1[0] + p[0],this1[1] + p[1],this1[2] + p[2]];
	}
	,reverse: function() {
		return new thx_geom_Line3D(this.point,(function($this) {
			var $r;
			var this1 = $this.direction;
			$r = [-this1[0],-this1[1],-this1[2]];
			return $r;
		}(this)));
	}
	,transform: function(matrix4x4) {
		var newpoint;
		var this1 = this.point;
		newpoint = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint3D(matrix4x4,[this1[0],this1[1],this1[2]]);
		var pointaddDirection;
		var this2 = this.point;
		var p = this.direction;
		pointaddDirection = [this2[0] + p[0],this2[1] + p[1],this2[2] + p[2]];
		var newPointaddDirection = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint3D(matrix4x4,[pointaddDirection[0],pointaddDirection[1],pointaddDirection[2]]);
		var newdirection;
		var p_0 = -newpoint[0];
		var p_1 = -newpoint[1];
		var p_2 = -newpoint[2];
		newdirection = [newPointaddDirection[0] + p_0,newPointaddDirection[1] + p_1,newPointaddDirection[2] + p_2];
		return new thx_geom_Line3D(newpoint,newdirection);
	}
	,closestPointOnLine: function(point) {
		var t = thx_geom__$Point3D_Point3D_$Impl_$.dot((function($this) {
			var $r;
			var p_0 = -point[0];
			var p_1 = -point[1];
			var p_2 = -point[2];
			$r = [point[0] + p_0,point[1] + p_1,point[2] + p_2];
			return $r;
		}(this)),this.direction) / thx_geom__$Point3D_Point3D_$Impl_$.dot(this.direction,this.direction);
		var p;
		var this1 = this.direction;
		p = [this1[0] * t,this1[1] * t,this1[2] * t];
		return [point[0] + p[0],point[1] + p[1],point[2] + p[2]];
	}
	,distanceToPoint: function(point) {
		var closestpoint = this.closestPointOnLine(point);
		var distancevector;
		var p_0 = -closestpoint[0];
		var p_1 = -closestpoint[1];
		var p_2 = -closestpoint[2];
		distancevector = [point[0] + p_0,point[1] + p_1,point[2] + p_2];
		return Math.sqrt(thx_geom__$Point3D_Point3D_$Impl_$.dot(distancevector,[distancevector[0],distancevector[1],distancevector[2]]));
	}
	,equals: function(line) {
		if(!thx_geom__$Point3D_Point3D_$Impl_$.equals(this.direction,line.direction)) return false;
		return this.distanceToPoint(line.point) <= 1e-8;
	}
	,__class__: thx_geom_Line3D
};
var thx_geom__$Matrix4x4_Matrix4x4_$Impl_$ = function() { };
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.__name__ = ["thx","geom","_Matrix4x4","Matrix4x4_Impl_"];
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.fromArray = function(e) {
	if(e.length != 16) throw "Invalid array length (" + e.length + ") for Matrix4x4, should be 16";
	return [e[0],e[1],e[2],e[3],e[4],e[5],e[6],e[7],e[8],e[9],e[10],e[11],e[12],e[13],e[14],e[15]];
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.rotationX = function(radians) {
	var cos = Math.cos(radians);
	var sin = Math.sin(radians);
	return [1,0,0,0,0,cos,sin,0,0,-sin,cos,0,0,0,0,1];
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.rotationY = function(radians) {
	var cos = Math.cos(radians);
	var sin = Math.sin(radians);
	return [cos,0,-sin,0,0,1,0,0,sin,0,cos,0,0,0,0,1];
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.rotationZ = function(radians) {
	var cos = Math.cos(radians);
	var sin = Math.sin(radians);
	return [cos,sin,0,0,-sin,cos,0,0,0,0,1,0,0,0,0,1];
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.rotation = function(rotationCenter,rotationAxis,radians) {
	var rotationPlane = thx_geom_Plane.fromNormalAndPoint(rotationAxis,rotationCenter);
	var orthobasis = new thx_geom_OrthoNormalBasis(rotationPlane,thx_geom__$Point3D_Point3D_$Impl_$.randomNonParallelVector(rotationPlane.normal));
	var transformation = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.translation([-rotationCenter[0],-rotationCenter[1],-rotationCenter[2]]);
	transformation = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.multiply(transformation,orthobasis.getProjectionMatrix());
	transformation = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.multiply(transformation,thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.rotationZ(radians));
	transformation = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.multiply(transformation,orthobasis.getInverseProjectionMatrix());
	transformation = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.multiply(transformation,thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.translation(rotationCenter));
	return transformation;
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.translation = function(vec) {
	return [1,0,0,0,0,1,0,0,0,0,1,0,vec[0],vec[1],vec[2],1];
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.mirroring = function(plane) {
	var nx = plane.normal[0];
	var ny = plane.normal[1];
	var nz = plane.normal[2];
	var w = plane.w;
	return [1.0 - 2.0 * nx * nx,-2. * ny * nx,-2. * nz * nx,0,-2. * nx * ny,1.0 - 2.0 * ny * ny,-2. * nz * ny,0,-2. * nx * nz,-2. * ny * nz,1.0 - 2.0 * nz * nz,0,-2. * nx * w,-2. * ny * w,-2. * nz * w,1];
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.scaling = function(vec) {
	return [vec[0],0,0,0,0,vec[1],0,0,0,0,vec[2],0,0,0,0,1];
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$._new = function(e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15) {
	return [e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15];
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.toArray = function(this1) {
	return this1.slice();
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.add = function(this1,other) {
	return [this1[0] + other[0],this1[1] + other[1],this1[2] + other[2],this1[3] + other[3],this1[4] + other[4],this1[5] + other[5],this1[6] + other[6],this1[7] + other[7],this1[8] + other[8],this1[9] + other[9],this1[10] + other[10],this1[11] + other[11],this1[12] + other[12],this1[13] + other[13],this1[14] + other[14],this1[15] + other[15]];
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.subtract = function(this1,other) {
	return [this1[0] - other[0],this1[1] - other[1],this1[2] - other[2],this1[3] - other[3],this1[4] - other[4],this1[5] - other[5],this1[6] - other[6],this1[7] - other[7],this1[8] - other[8],this1[9] - other[9],this1[10] - other[10],this1[11] - other[11],this1[12] - other[12],this1[13] - other[13],this1[14] - other[14],this1[15] - other[15]];
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.multiply = function(this1,other) {
	var t0 = this1[0];
	var t1 = this1[1];
	var t2 = this1[2];
	var t3 = this1[3];
	var t4 = this1[4];
	var t5 = this1[5];
	var t6 = this1[6];
	var t7 = this1[7];
	var t8 = this1[8];
	var t9 = this1[9];
	var t10 = this1[10];
	var t11 = this1[11];
	var t12 = this1[12];
	var t13 = this1[13];
	var t14 = this1[14];
	var t15 = this1[15];
	var m0 = other[0];
	var m1 = other[1];
	var m2 = other[2];
	var m3 = other[3];
	var m4 = other[4];
	var m5 = other[5];
	var m6 = other[6];
	var m7 = other[7];
	var m8 = other[8];
	var m9 = other[9];
	var m10 = other[10];
	var m11 = other[11];
	var m12 = other[12];
	var m13 = other[13];
	var m14 = other[14];
	var m15 = other[15];
	return [t0 * m0 + t1 * m4 + t2 * m8 + t3 * m12,t0 * m1 + t1 * m5 + t2 * m9 + t3 * m13,t0 * m2 + t1 * m6 + t2 * m10 + t3 * m14,t0 * m3 + t1 * m7 + t2 * m11 + t3 * m15,t4 * m0 + t5 * m4 + t6 * m8 + t7 * m12,t4 * m1 + t5 * m5 + t6 * m9 + t7 * m13,t4 * m2 + t5 * m6 + t6 * m10 + t7 * m14,t4 * m3 + t5 * m7 + t6 * m11 + t7 * m15,t8 * m0 + t9 * m4 + t10 * m8 + t11 * m12,t8 * m1 + t9 * m5 + t10 * m9 + t11 * m13,t8 * m2 + t9 * m6 + t10 * m10 + t11 * m14,t8 * m3 + t9 * m7 + t10 * m11 + t11 * m15,t12 * m0 + t13 * m4 + t14 * m8 + t15 * m12,t12 * m1 + t13 * m5 + t14 * m9 + t15 * m13,t12 * m2 + t13 * m6 + t14 * m10 + t15 * m14,t12 * m3 + t13 * m7 + t14 * m11 + t15 * m15];
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.rightMultiplyPoint3D = function(this1,vector) {
	var v0 = vector[0];
	var v1 = vector[1];
	var v2 = vector[2];
	var v3 = 1;
	var x = v0 * this1[0] + v1 * this1[1] + v2 * this1[2] + v3 * this1[3];
	var y = v0 * this1[4] + v1 * this1[5] + v2 * this1[6] + v3 * this1[7];
	var z = v0 * this1[8] + v1 * this1[9] + v2 * this1[10] + v3 * this1[11];
	var w = v0 * this1[12] + v1 * this1[13] + v2 * this1[14] + v3 * this1[15];
	if(w != 1) {
		var invw = 1.0 / w;
		x *= invw;
		y *= invw;
		z *= invw;
	}
	return [x,y,z];
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint3D = function(this1,vector) {
	var v0 = vector[0];
	var v1 = vector[1];
	var v2 = vector[2];
	var v3 = 1;
	var x = v0 * this1[0] + v1 * this1[4] + v2 * this1[8] + v3 * this1[12];
	var y = v0 * this1[1] + v1 * this1[5] + v2 * this1[9] + v3 * this1[13];
	var z = v0 * this1[2] + v1 * this1[6] + v2 * this1[10] + v3 * this1[14];
	var w = v0 * this1[3] + v1 * this1[7] + v2 * this1[11] + v3 * this1[15];
	if(w != 1) {
		var invw = 1.0 / w;
		x *= invw;
		y *= invw;
		z *= invw;
	}
	return [x,y,z];
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.rightMultiplyPoint = function(this1,vector) {
	var v0 = vector[0];
	var v1 = vector[1];
	var v2 = 0;
	var v3 = 1;
	var x = v0 * this1[0] + v1 * this1[1] + v2 * this1[2] + v3 * this1[3];
	var y = v0 * this1[4] + v1 * this1[5] + v2 * this1[6] + v3 * this1[7];
	var z = v0 * this1[8] + v1 * this1[9] + v2 * this1[10] + v3 * this1[11];
	var w = v0 * this1[12] + v1 * this1[13] + v2 * this1[14] + v3 * this1[15];
	if(w != 1) {
		var invw = 1.0 / w;
		x *= invw;
		y *= invw;
		z *= invw;
	}
	return [x,y];
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint = function(this1,vector) {
	var v0 = vector[0];
	var v1 = vector[1];
	var v2 = 0;
	var v3 = 1;
	var x = v0 * this1[0] + v1 * this1[4] + v2 * this1[8] + v3 * this1[12];
	var y = v0 * this1[1] + v1 * this1[5] + v2 * this1[9] + v3 * this1[13];
	var z = v0 * this1[2] + v1 * this1[6] + v2 * this1[10] + v3 * this1[14];
	var w = v0 * this1[3] + v1 * this1[7] + v2 * this1[11] + v3 * this1[15];
	if(w != 1) {
		var invw = 1.0 / w;
		x *= invw;
		y *= invw;
		z *= invw;
	}
	return [x,y];
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.isMirroring = function(this1) {
	var u_0 = this1[0];
	var u_1 = this1[4];
	var u_2 = this1[8];
	var v_0 = this1[1];
	var v_1 = this1[5];
	var v_2 = this1[9];
	var w = [this1[2],this1[6],this1[10]];
	var mirrorvalue = thx_geom__$Point3D_Point3D_$Impl_$.dot([u_1 * v_2 - u_2 * v_1,u_2 * v_0 - u_0 * v_2,u_0 * v_1 - u_1 * v_0],w);
	var ismirror = mirrorvalue < 0;
	return ismirror;
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.at = function(this1,index) {
	return this1[index];
};
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.toString = function(this1) {
	return "Matrix(" + this1.join(",") + ")";
};
var thx_geom_Plane = function(normal,w) {
	this.normal = normal;
	this.w = w;
};
thx_geom_Plane.__name__ = ["thx","geom","Plane"];
thx_geom_Plane.fromPoint3Ds = function(a,b,c) {
	var n;
	var this1;
	var this2;
	var p_0 = -a[0];
	var p_1 = -a[1];
	var p_2 = -a[2];
	this2 = [b[0] + p_0,b[1] + p_1,b[2] + p_2];
	var p;
	var p_01 = -a[0];
	var p_11 = -a[1];
	var p_21 = -a[2];
	p = [c[0] + p_01,c[1] + p_11,c[2] + p_21];
	this1 = [this2[1] * p[2] - this2[2] * p[1],this2[2] * p[0] - this2[0] * p[2],this2[0] * p[1] - this2[1] * p[0]];
	var v = Math.sqrt(thx_geom__$Point3D_Point3D_$Impl_$.dot(this1,[this1[0],this1[1],this1[2]]));
	n = [this1[0] / v,this1[1] / v,this1[2] / v];
	return new thx_geom_Plane(n,thx_geom__$Point3D_Point3D_$Impl_$.dot(n,a));
};
thx_geom_Plane.anyPlaneFromPoint3Ds = function(a,b,c) {
	var v1;
	var p_0 = -a[0];
	var p_1 = -a[1];
	var p_2 = -a[2];
	v1 = [b[0] + p_0,b[1] + p_1,b[2] + p_2];
	var v2;
	var p_01 = -a[0];
	var p_11 = -a[1];
	var p_21 = -a[2];
	v2 = [c[0] + p_01,c[1] + p_11,c[2] + p_21];
	if(Math.sqrt(thx_geom__$Point3D_Point3D_$Impl_$.dot(v1,[v1[0],v1[1],v1[2]])) < 1e-5) v1 = thx_geom__$Point3D_Point3D_$Impl_$.randomNonParallelVector(v2);
	if(Math.sqrt(thx_geom__$Point3D_Point3D_$Impl_$.dot(v2,[v2[0],v2[1],v2[2]])) < 1e-5) v2 = thx_geom__$Point3D_Point3D_$Impl_$.randomNonParallelVector(v1);
	var normal = [v1[1] * v2[2] - v1[2] * v2[1],v1[2] * v2[0] - v1[0] * v2[2],v1[0] * v2[1] - v1[1] * v2[0]];
	if(Math.sqrt(thx_geom__$Point3D_Point3D_$Impl_$.dot(normal,[normal[0],normal[1],normal[2]])) < 1e-5) {
		v2 = thx_geom__$Point3D_Point3D_$Impl_$.randomNonParallelVector(v1);
		normal = [v1[1] * v2[2] - v1[2] * v2[1],v1[2] * v2[0] - v1[0] * v2[2],v1[0] * v2[1] - v1[1] * v2[0]];
	}
	var v = Math.sqrt(thx_geom__$Point3D_Point3D_$Impl_$.dot(normal,[normal[0],normal[1],normal[2]]));
	normal = [normal[0] / v,normal[1] / v,normal[2] / v];
	return new thx_geom_Plane(normal,thx_geom__$Point3D_Point3D_$Impl_$.dot(normal,a));
};
thx_geom_Plane.fromPoints = function(a,b,c) {
	var n;
	var this1;
	var this2;
	var p_0 = -a[0];
	var p_1 = -a[1];
	var p_2 = -a[2];
	this2 = [b[0] + p_0,b[1] + p_1,b[2] + p_2];
	var p;
	var p_01 = -a[0];
	var p_11 = -a[1];
	var p_21 = -a[2];
	p = [c[0] + p_01,c[1] + p_11,c[2] + p_21];
	this1 = [this2[1] * p[2] - this2[2] * p[1],this2[2] * p[0] - this2[0] * p[2],this2[0] * p[1] - this2[1] * p[0]];
	var v = Math.sqrt(thx_geom__$Point3D_Point3D_$Impl_$.dot(this1,[this1[0],this1[1],this1[2]]));
	n = [this1[0] / v,this1[1] / v,this1[2] / v];
	return new thx_geom_Plane(n,thx_geom__$Point3D_Point3D_$Impl_$.dot(n,a));
};
thx_geom_Plane.fromNormalAndPoint = function(normal,point) {
	var v = Math.sqrt(thx_geom__$Point3D_Point3D_$Impl_$.dot(normal,[normal[0],normal[1],normal[2]]));
	normal = [normal[0] / v,normal[1] / v,normal[2] / v];
	return new thx_geom_Plane(normal,thx_geom__$Point3D_Point3D_$Impl_$.dot(point,normal));
};
thx_geom_Plane.prototype = {
	normal: null
	,w: null
	,flip: function() {
		return new thx_geom_Plane((function($this) {
			var $r;
			var this1 = $this.normal;
			$r = [-this1[0],-this1[1],-this1[2]];
			return $r;
		}(this)),-this.w);
	}
	,splitPolygon: function(polygon,coplanarFront,coplanarBack,front,back) {
		var polygonType = 0;
		var types = [];
		var t;
		var type;
		var f;
		var b;
		var len;
		var j;
		var ti;
		var vi;
		var tj;
		var vj;
		var t1;
		var v;
		var $it0 = HxOverrides.iter(polygon.vertices);
		while( $it0.hasNext() ) {
			var vertex = $it0.next();
			t1 = thx_geom__$Point3D_Point3D_$Impl_$.dot(this.normal,vertex.position) - this.w;
			if(t1 < -1e-05) type = 2; else if(t1 > 1e-5) type = 1; else type = 0;
			polygonType |= type;
			types.push(type);
		}
		switch(polygonType) {
		case 0:
			(thx_geom__$Point3D_Point3D_$Impl_$.dot(this.normal,polygon.get_plane().normal) > 0?coplanarFront:coplanarBack).push(polygon);
			break;
		case 1:
			front.push(polygon);
			break;
		case 2:
			back.push(polygon);
			break;
		case 3:
			f = [];
			b = [];
			len = polygon.vertices.length;
			var _g = 0;
			while(_g < len) {
				var i = _g++;
				j = (i + 1) % len;
				ti = types[i];
				tj = types[j];
				vi = polygon.vertices[i];
				vj = polygon.vertices[j];
				if(ti != 2) f.push(vi);
				if(ti != 1) b.push(vi);
				if((ti | tj) == 3) {
					t1 = (this.w - thx_geom__$Point3D_Point3D_$Impl_$.dot(this.normal,vi.position)) / thx_geom__$Point3D_Point3D_$Impl_$.dot(this.normal,(function($this) {
						var $r;
						var this1 = vj.position;
						var p = vi.position;
						var p_0 = -p[0];
						var p_1 = -p[1];
						var p_2 = -p[2];
						$r = [this1[0] + p_0,this1[1] + p_1,this1[2] + p_2];
						return $r;
					}(this)));
					v = new thx_geom_Vertex3D(thx_geom__$Point3D_Point3D_$Impl_$.interpolate(vi.position,vj.position,t1),thx_geom__$Point3D_Point3D_$Impl_$.interpolate(vi.normal,vj.normal,t1));
					f.push(v);
					b.push(v);
				}
			}
			if(f.length >= 3) front.push(new thx_geom_Polygon(f));
			if(b.length >= 3) back.push(new thx_geom_Polygon(b));
			break;
		}
	}
	,equals: function(other) {
		return thx_geom__$Point3D_Point3D_$Impl_$.equals(this.normal,other.normal) && this.w == other.w;
	}
	,transform: function(matrix) {
		var ismirror = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.isMirroring(matrix);
		var r = thx_geom__$Point3D_Point3D_$Impl_$.randomNonParallelVector(this.normal);
		var u;
		var this1 = this.normal;
		u = [this1[1] * r[2] - this1[2] * r[1],this1[2] * r[0] - this1[0] * r[2],this1[0] * r[1] - this1[1] * r[0]];
		var v;
		var this2 = this.normal;
		v = [this2[1] * u[2] - this2[2] * u[1],this2[2] * u[0] - this2[0] * u[2],this2[0] * u[1] - this2[1] * u[0]];
		var point1;
		var this3 = this.normal;
		var v1 = this.w;
		point1 = [this3[0] * v1,this3[1] * v1,this3[2] * v1];
		var point2 = [point1[0] + u[0],point1[1] + u[1],point1[2] + u[2]];
		var point3 = [point1[0] + v[0],point1[1] + v[1],point1[2] + v[2]];
		point1 = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint3D(matrix,[point1[0],point1[1],point1[2]]);
		point2 = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint3D(matrix,[point2[0],point2[1],point2[2]]);
		point3 = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint3D(matrix,[point3[0],point3[1],point3[2]]);
		var newplane = thx_geom_Plane.fromPoint3Ds(point1,point2,point3);
		if(ismirror) newplane = newplane.flip();
		return newplane;
	}
	,splitLineBetweenPoints: function(p1,p2) {
		var direction;
		var p_0 = -p1[0];
		var p_1 = -p1[1];
		var p_2 = -p1[2];
		direction = [p2[0] + p_0,p2[1] + p_1,p2[2] + p_2];
		var lambda = (this.w - thx_geom__$Point3D_Point3D_$Impl_$.dot(this.normal,p1)) / thx_geom__$Point3D_Point3D_$Impl_$.dot(this.normal,direction);
		if(isNaN(lambda)) lambda = 0; else if(lambda > 1) lambda = 1; else if(lambda < 0) lambda = 0;
		var p_01 = direction[0] * lambda;
		var p_11 = direction[1] * lambda;
		var p_21 = direction[2] * lambda;
		return [p1[0] + p_01,p1[1] + p_11,p1[2] + p_21];
	}
	,intersectWithLine: function(line) {
		return line.intersectWithPlane(this);
	}
	,intersectWithPlane: function(plane) {
		return thx_geom_Line3D.fromPlanes(this,plane);
	}
	,signedDistanceToPoint: function(point) {
		return thx_geom__$Point3D_Point3D_$Impl_$.dot(this.normal,point) - this.w;
	}
	,toString: function() {
		return "Plane [normal: " + (function($this) {
			var $r;
			var this1 = $this.normal;
			$r = "Point3D(" + this1[0] + "," + this1[1] + "," + this1[2] + ")";
			return $r;
		}(this)) + ", w: " + this.w + "]";
	}
	,mirrorPoint: function(point3d) {
		var distance = this.signedDistanceToPoint(point3d);
		var mirrored;
		var p;
		var this1 = this.normal;
		var v = distance * 2.0;
		p = [this1[0] * v,this1[1] * v,this1[2] * v];
		var p_0 = -p[0];
		var p_1 = -p[1];
		var p_2 = -p[2];
		mirrored = [point3d[0] + p_0,point3d[1] + p_1,point3d[2] + p_2];
		return mirrored;
	}
	,__class__: thx_geom_Plane
};
var thx_geom__$Point3D_Point3D_$Impl_$ = function() { };
thx_geom__$Point3D_Point3D_$Impl_$.__name__ = ["thx","geom","_Point3D","Point3D_Impl_"];
thx_geom__$Point3D_Point3D_$Impl_$.fromObject = function(o) {
	return [o.x,o.y,o.z];
};
thx_geom__$Point3D_Point3D_$Impl_$.fromArray = function(arr) {
	return [arr[0],arr[1],arr[2]];
};
thx_geom__$Point3D_Point3D_$Impl_$._new = function(x,y,z) {
	return [x,y,z];
};
thx_geom__$Point3D_Point3D_$Impl_$.get_x = function(this1) {
	return this1[0];
};
thx_geom__$Point3D_Point3D_$Impl_$.get_y = function(this1) {
	return this1[1];
};
thx_geom__$Point3D_Point3D_$Impl_$.get_z = function(this1) {
	return this1[2];
};
thx_geom__$Point3D_Point3D_$Impl_$.get_length = function(this1) {
	return Math.sqrt(thx_geom__$Point3D_Point3D_$Impl_$.dot(this1,[this1[0],this1[1],this1[2]]));
};
thx_geom__$Point3D_Point3D_$Impl_$.get_lengthSquared = function(this1) {
	return thx_geom__$Point3D_Point3D_$Impl_$.dot(this1,[this1[0],this1[1],this1[2]]);
};
thx_geom__$Point3D_Point3D_$Impl_$.get_inst = function(this1) {
	return this1;
};
thx_geom__$Point3D_Point3D_$Impl_$.addPoint3D = function(this1,p) {
	return [this1[0] + p[0],this1[1] + p[1],this1[2] + p[2]];
};
thx_geom__$Point3D_Point3D_$Impl_$.add = function(this1,v) {
	return [this1[0] + v,this1[1] + v,this1[2] + v];
};
thx_geom__$Point3D_Point3D_$Impl_$.negate = function(this1) {
	return [-this1[0],-this1[1],-this1[2]];
};
thx_geom__$Point3D_Point3D_$Impl_$.subtractPoint3D = function(this1,p) {
	var p_0 = -p[0];
	var p_1 = -p[1];
	var p_2 = -p[2];
	return [this1[0] + p_0,this1[1] + p_1,this1[2] + p_2];
};
thx_geom__$Point3D_Point3D_$Impl_$.subtract = function(this1,v) {
	var v1 = -v;
	return [this1[0] + v1,this1[1] + v1,this1[2] + v1];
};
thx_geom__$Point3D_Point3D_$Impl_$.multiplyPoint3D = function(this1,p) {
	return [this1[0] * p[0],this1[1] * p[1],this1[2] * p[2]];
};
thx_geom__$Point3D_Point3D_$Impl_$.multiply = function(this1,v) {
	return [this1[0] * v,this1[1] * v,this1[2] * v];
};
thx_geom__$Point3D_Point3D_$Impl_$.dividePoint3D = function(this1,p) {
	return [this1[0] / p[0],this1[1] / p[1],this1[2] / p[2]];
};
thx_geom__$Point3D_Point3D_$Impl_$.divide = function(this1,v) {
	return [this1[0] / v,this1[1] / v,this1[2] / v];
};
thx_geom__$Point3D_Point3D_$Impl_$.equals = function(this1,p) {
	return this1[0] == p[0] && this1[1] == p[1] && this1[2] == p[2];
};
thx_geom__$Point3D_Point3D_$Impl_$.notEquals = function(this1,p) {
	return !thx_geom__$Point3D_Point3D_$Impl_$.equals(this1,p);
};
thx_geom__$Point3D_Point3D_$Impl_$.abs = function(this1) {
	var x = Math.abs(this1[0]);
	var y = Math.abs(this1[1]);
	var z = Math.abs(this1[2]);
	return [x,y,z];
};
thx_geom__$Point3D_Point3D_$Impl_$.nearEquals = function(this1,p) {
	return Math.abs(this1[0] - p[0]) <= 1e-5 && Math.abs(this1[1] - p[1]) <= 1e-5 && Math.abs(this1[2] - p[2]) <= 1e-5;
};
thx_geom__$Point3D_Point3D_$Impl_$.interpolate = function(this1,p,f) {
	var p1;
	var this2;
	var p_0 = this1[0];
	var p_1 = this1[1];
	var p_2 = this1[2];
	var p_01 = -p_0;
	var p_11 = -p_1;
	var p_21 = -p_2;
	this2 = [p[0] + p_01,p[1] + p_11,p[2] + p_21];
	p1 = [this2[0] * f,this2[1] * f,this2[2] * f];
	return [this1[0] + p1[0],this1[1] + p1[1],this1[2] + p1[2]];
};
thx_geom__$Point3D_Point3D_$Impl_$.isZero = function(this1) {
	return thx_geom__$Point3D_Point3D_$Impl_$.equals(this1,thx_geom__$Point3D_Point3D_$Impl_$.zero);
};
thx_geom__$Point3D_Point3D_$Impl_$.isNearZero = function(this1) {
	return thx_geom__$Point3D_Point3D_$Impl_$.nearEquals(this1,thx_geom__$Point3D_Point3D_$Impl_$.zero);
};
thx_geom__$Point3D_Point3D_$Impl_$.dot = function(this1,prod) {
	return this1[0] * prod[0] + this1[1] * prod[1] + this1[2] * prod[2];
};
thx_geom__$Point3D_Point3D_$Impl_$.normalize = function(this1) {
	var v = Math.sqrt(thx_geom__$Point3D_Point3D_$Impl_$.dot(this1,[this1[0],this1[1],this1[2]]));
	return [this1[0] / v,this1[1] / v,this1[2] / v];
};
thx_geom__$Point3D_Point3D_$Impl_$.distanceTo = function(this1,p) {
	var this2;
	var p_0 = -p[0];
	var p_1 = -p[1];
	var p_2 = -p[2];
	this2 = [this1[0] + p_0,this1[1] + p_1,this1[2] + p_2];
	return Math.sqrt(thx_geom__$Point3D_Point3D_$Impl_$.dot(this2,[this2[0],this2[1],this2[2]]));
};
thx_geom__$Point3D_Point3D_$Impl_$.distanceToSquared = function(this1,p) {
	var this2;
	var p_0 = -p[0];
	var p_1 = -p[1];
	var p_2 = -p[2];
	this2 = [this1[0] + p_0,this1[1] + p_1,this1[2] + p_2];
	return thx_geom__$Point3D_Point3D_$Impl_$.dot(this2,[this2[0],this2[1],this2[2]]);
};
thx_geom__$Point3D_Point3D_$Impl_$.multiply4x4 = function(this1,matrix4x4) {
	return thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint3D(matrix4x4,[this1[0],this1[1],this1[2]]);
};
thx_geom__$Point3D_Point3D_$Impl_$.transform = function(this1,matrix4x4) {
	return thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint3D(matrix4x4,[this1[0],this1[1],this1[2]]);
};
thx_geom__$Point3D_Point3D_$Impl_$.randomNonParallelVector = function(this1) {
	var a = thx_geom__$Point3D_Point3D_$Impl_$.abs(this1);
	if(a[0] <= a[1] && a[0] <= a[2]) return [1,0,0]; else if(a[1] <= a[0] && a[1] <= a[2]) return [0,1,0]; else return [0,0,1];
};
thx_geom__$Point3D_Point3D_$Impl_$.cross = function(this1,p) {
	return [this1[1] * p[2] - this1[2] * p[1],this1[2] * p[0] - this1[0] * p[2],this1[0] * p[1] - this1[1] * p[0]];
};
thx_geom__$Point3D_Point3D_$Impl_$.min = function(this1,p) {
	var x = Math.min(this1[0],p[0]);
	var y = Math.min(this1[1],p[1]);
	var z = Math.min(this1[2],p[2]);
	return [x,y,z];
};
thx_geom__$Point3D_Point3D_$Impl_$.max = function(this1,p) {
	var x = Math.max(this1[0],p[0]);
	var y = Math.max(this1[1],p[1]);
	var z = Math.max(this1[2],p[2]);
	return [x,y,z];
};
thx_geom__$Point3D_Point3D_$Impl_$.toArray = function(this1) {
	return this1.slice();
};
thx_geom__$Point3D_Point3D_$Impl_$.toObject = function(this1) {
	return { x : this1[0], y : this1[1], z : this1[2]};
};
thx_geom__$Point3D_Point3D_$Impl_$.toString = function(this1) {
	return "Point3D(" + this1[0] + "," + this1[1] + "," + this1[2] + ")";
};
var thx_geom_OrthoNormalBasis = function(plane,rightvector) {
	var this1;
	var this2 = plane.normal;
	this1 = [this2[1] * rightvector[2] - this2[2] * rightvector[1],this2[2] * rightvector[0] - this2[0] * rightvector[2],this2[0] * rightvector[1] - this2[1] * rightvector[0]];
	var v = Math.sqrt(thx_geom__$Point3D_Point3D_$Impl_$.dot(this1,[this1[0],this1[1],this1[2]]));
	this.v = [this1[0] / v,this1[1] / v,this1[2] / v];
	var this3 = this.v;
	var p = plane.normal;
	this.u = [this3[1] * p[2] - this3[2] * p[1],this3[2] * p[0] - this3[0] * p[2],this3[0] * p[1] - this3[1] * p[0]];
	this.plane = plane;
	var this4 = plane.normal;
	var v1 = plane.w;
	this.planeOrigin = [this4[0] * v1,this4[1] * v1,this4[2] * v1];
};
thx_geom_OrthoNormalBasis.__name__ = ["thx","geom","OrthoNormalBasis"];
thx_geom_OrthoNormalBasis.fromPlane = function(plane) {
	return new thx_geom_OrthoNormalBasis(plane,thx_geom__$Point3D_Point3D_$Impl_$.randomNonParallelVector(plane.normal));
};
thx_geom_OrthoNormalBasis.prototype = {
	v: null
	,u: null
	,plane: null
	,planeOrigin: null
	,getProjectionMatrix: function() {
		return [this.u[0],this.v[0],this.plane.normal[0],0,this.u[1],this.v[1],this.plane.normal[1],0,this.u[2],this.v[2],this.plane.normal[2],0,0,0,-this.plane.w,1];
	}
	,getInverseProjectionMatrix: function() {
		var p;
		var this1 = this.plane.normal;
		var v = this.plane.w;
		p = [this1[0] * v,this1[1] * v,this1[2] * v];
		return [this.u[0],this.u[1],this.u[2],0,this.v[0],this.v[1],this.v[2],0,this.plane.normal[0],this.plane.normal[1],this.plane.normal[2],0,p[0],p[1],p[2],1];
	}
	,to2D: function(vec3) {
		var x = thx_geom__$Point3D_Point3D_$Impl_$.dot(vec3,this.u);
		var y = thx_geom__$Point3D_Point3D_$Impl_$.dot(vec3,this.v);
		return [x,y];
	}
	,to3D: function(vec2) {
		var this1;
		var this2 = this.planeOrigin;
		var p;
		var this3 = this.u;
		var v = vec2[0];
		p = [this3[0] * v,this3[1] * v,this3[2] * v];
		this1 = [this2[0] + p[0],this2[1] + p[1],this2[2] + p[2]];
		var p1;
		var this4 = this.v;
		var v1 = vec2[1];
		p1 = [this4[0] * v1,this4[1] * v1,this4[2] * v1];
		return [this1[0] + p1[0],this1[1] + p1[1],this1[2] + p1[2]];
	}
	,line3Dto2D: function(line) {
		return thx_geom_Line.fromPoints(this.to2D(line.point),this.to2D((function($this) {
			var $r;
			var this1 = line.direction;
			var p = line.point;
			$r = [this1[0] + p[0],this1[1] + p[1],this1[2] + p[2]];
			return $r;
		}(this))));
	}
	,line2Dto3D: function(line) {
		var a = line.origin();
		var b;
		var this1 = line.direction();
		b = [this1[0] + a[0],this1[1] + a[1]];
		return thx_geom_Line3D.fromPoints(this.to3D(a),this.to3D(b));
	}
	,transform: function(matrix) {
		var newplane = this.plane.transform(matrix);
		var rightpoint_transformed;
		var this1 = this.u;
		rightpoint_transformed = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint3D(matrix,[this1[0],this1[1],this1[2]]);
		var origin_transformed;
		var this_0 = 0;
		var this_1 = 0;
		var this_2 = 0;
		origin_transformed = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint3D(matrix,[this_0,this_1,this_2]);
		var newrighthandvector;
		var p_0 = -origin_transformed[0];
		var p_1 = -origin_transformed[1];
		var p_2 = -origin_transformed[2];
		newrighthandvector = [rightpoint_transformed[0] + p_0,rightpoint_transformed[1] + p_1,rightpoint_transformed[2] + p_2];
		var newbasis = new thx_geom_OrthoNormalBasis(newplane,newrighthandvector);
		return newbasis;
	}
	,__class__: thx_geom_OrthoNormalBasis
};
var thx_geom__$Point_Point_$Impl_$ = function() { };
thx_geom__$Point_Point_$Impl_$.__name__ = ["thx","geom","_Point","Point_Impl_"];
thx_geom__$Point_Point_$Impl_$.fromObject = function(o) {
	return [o.x,o.y];
};
thx_geom__$Point_Point_$Impl_$.fromArray = function(arr) {
	return [arr[0],arr[1]];
};
thx_geom__$Point_Point_$Impl_$.fromAngle = function(angle) {
	var x = Math.cos(angle);
	var y = Math.sin(angle);
	return [x,y];
};
thx_geom__$Point_Point_$Impl_$._new = function(x,y) {
	return [x,y];
};
thx_geom__$Point_Point_$Impl_$.get_x = function(this1) {
	return this1[0];
};
thx_geom__$Point_Point_$Impl_$.get_y = function(this1) {
	return this1[1];
};
thx_geom__$Point_Point_$Impl_$.get_length = function(this1) {
	return Math.sqrt(this1[0] * this1[0] + this1[1] * this1[1]);
};
thx_geom__$Point_Point_$Impl_$.get_lengthSquared = function(this1) {
	return this1[0] * this1[0] + this1[1] * this1[1];
};
thx_geom__$Point_Point_$Impl_$.get_inst = function(this1) {
	return this1;
};
thx_geom__$Point_Point_$Impl_$.addPoint = function(this1,p) {
	return [this1[0] + p[0],this1[1] + p[1]];
};
thx_geom__$Point_Point_$Impl_$.add = function(this1,v) {
	return [this1[0] + v,this1[1] + v];
};
thx_geom__$Point_Point_$Impl_$.negate = function(this1) {
	return [-this1[0],-this1[1]];
};
thx_geom__$Point_Point_$Impl_$.subtractPoint = function(this1,p) {
	var p_0 = -p[0];
	var p_1 = -p[1];
	return [this1[0] + p_0,this1[1] + p_1];
};
thx_geom__$Point_Point_$Impl_$.subtract = function(this1,v) {
	var v1 = -v;
	return [this1[0] + v1,this1[1] + v1];
};
thx_geom__$Point_Point_$Impl_$.multiplyPoint = function(this1,p) {
	return [this1[0] * p[0],this1[1] * p[1]];
};
thx_geom__$Point_Point_$Impl_$.multiply = function(this1,v) {
	return [this1[0] * v,this1[1] * v];
};
thx_geom__$Point_Point_$Impl_$.dividePoint = function(this1,p) {
	return [this1[0] / p[0],this1[1] / p[1]];
};
thx_geom__$Point_Point_$Impl_$.divide = function(this1,v) {
	return [this1[0] / v,this1[1] / v];
};
thx_geom__$Point_Point_$Impl_$.equals = function(this1,p) {
	return this1[0] == p[0] && this1[1] == p[1];
};
thx_geom__$Point_Point_$Impl_$.notEquals = function(this1,p) {
	return !(this1[0] == p[0] && this1[1] == p[1]);
};
thx_geom__$Point_Point_$Impl_$.abs = function(this1) {
	var x = Math.abs(this1[0]);
	var y = Math.abs(this1[1]);
	return [x,y];
};
thx_geom__$Point_Point_$Impl_$.nearEquals = function(this1,p) {
	return Math.abs(this1[0] - p[0]) <= 1e-5 && Math.abs(this1[1] - p[1]) <= 1e-5;
};
thx_geom__$Point_Point_$Impl_$.interpolate = function(this1,p,f) {
	var p1;
	var this2;
	var p2 = this1;
	var p_0 = -p2[0];
	var p_1 = -p2[1];
	this2 = [p[0] + p_0,p[1] + p_1];
	p1 = [this2[0] * f,this2[1] * f];
	return [this1[0] + p1[0],this1[1] + p1[1]];
};
thx_geom__$Point_Point_$Impl_$.isZero = function(this1) {
	var p = thx_geom__$Point_Point_$Impl_$.zero;
	return this1[0] == p[0] && this1[1] == p[1];
};
thx_geom__$Point_Point_$Impl_$.isNearZero = function(this1) {
	return thx_geom__$Point_Point_$Impl_$.nearEquals(this1,thx_geom__$Point_Point_$Impl_$.zero);
};
thx_geom__$Point_Point_$Impl_$.dot = function(this1,p) {
	return this1[0] * p[0] + this1[1] * p[1];
};
thx_geom__$Point_Point_$Impl_$.normal = function(this1) {
	return [this1[1],-this1[0]];
};
thx_geom__$Point_Point_$Impl_$.normalize = function(this1) {
	var v = Math.sqrt(this1[0] * this1[0] + this1[1] * this1[1]);
	return [this1[0] / v,this1[1] / v];
};
thx_geom__$Point_Point_$Impl_$.distanceTo = function(this1,p) {
	var this2;
	var p_0 = -p[0];
	var p_1 = -p[1];
	this2 = [this1[0] + p_0,this1[1] + p_1];
	return Math.sqrt(this2[0] * this2[0] + this2[1] * this2[1]);
};
thx_geom__$Point_Point_$Impl_$.distanceToSquared = function(this1,p) {
	var this2;
	var p_0 = -p[0];
	var p_1 = -p[1];
	this2 = [this1[0] + p_0,this1[1] + p_1];
	return this2[0] * this2[0] + this2[1] * this2[1];
};
thx_geom__$Point_Point_$Impl_$.transform = function(this1,matrix) {
	return thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint(matrix,this1);
};
thx_geom__$Point_Point_$Impl_$.cross = function(this1,p) {
	return this1[0] * p[1] - this1[1] * p[0];
};
thx_geom__$Point_Point_$Impl_$.min = function(this1,p) {
	var x = Math.min(this1[0],p[0]);
	var y = Math.min(this1[1],p[1]);
	return [x,y];
};
thx_geom__$Point_Point_$Impl_$.max = function(this1,p) {
	var x = Math.max(this1[0],p[0]);
	var y = Math.max(this1[1],p[1]);
	return [x,y];
};
thx_geom__$Point_Point_$Impl_$.pointAt = function(this1,angle,distance) {
	var this2 = this1;
	var p;
	var this3;
	var x = Math.cos(angle);
	var y = Math.sin(angle);
	this3 = [x,y];
	p = [this3[0] * distance,this3[1] * distance];
	return [this2[0] + p[0],this2[1] + p[1]];
};
thx_geom__$Point_Point_$Impl_$.toAngle = function(this1) {
	var angle = Math.atan2(this1[1],this1[0]);
	return angle;
};
thx_geom__$Point_Point_$Impl_$.toArray = function(this1) {
	return this1.slice();
};
thx_geom__$Point_Point_$Impl_$.toObject = function(this1) {
	return { x : this1[0], y : this1[1]};
};
thx_geom__$Point_Point_$Impl_$.toString = function(this1) {
	return "Point(" + this1[0] + "," + this1[1] + ")";
};
thx_geom__$Point_Point_$Impl_$.solve2Linear = function(a,b,c,d,u,v) {
	var det = a * d - b * c;
	if(det == 0) return null;
	var invdet = 1.0 / det;
	var x = u * d - b * v;
	var y = -u * c + a * v;
	return [x * invdet,y * invdet];
};
thx_geom__$Point_Point_$Impl_$.interpolateBetween2DPointsForY = function(p1,p2,y) {
	var f1 = y - p1[1];
	var f2 = p2[1] - p1[1];
	var t;
	if(f2 < 0) {
		f1 = -f1;
		f2 = -f2;
	}
	if(f1 <= 0) t = 0.0; else if(f1 >= f2) t = 1.0; else if(f2 < 1e-10) t = 0.5; else t = f1 / f2;
	return p1[0] + t * (p2[0] - p1[0]);
};
var thx_geom_Polygon = function(vertices) {
	this.vertices = vertices;
};
thx_geom_Polygon.__name__ = ["thx","geom","Polygon"];
thx_geom_Polygon.fromVertices = function(vertices) {
	if((vertices instanceof Array) && vertices.__enum__ == null) return new thx_geom_Polygon(vertices.copy()); else return new thx_geom_Polygon((function($this) {
		var $r;
		var _g = [];
		var $it0 = $iterator(vertices)();
		while( $it0.hasNext() ) {
			var v = $it0.next();
			_g.push(v);
		}
		$r = _g;
		return $r;
	}(this)));
};
thx_geom_Polygon.prototype = {
	plane: null
	,vertices: null
	,flip: function() {
		var reverse = this.vertices.slice();
		reverse.reverse();
		return new thx_geom_Polygon(reverse.map(function(v) {
			return v.flip();
		}));
	}
	,iterator: function() {
		return HxOverrides.iter(this.vertices);
	}
	,all: function() {
		return this.vertices.slice();
	}
	,get_plane: function() {
		if(null == this.plane) return this.plane = thx_geom_Plane.fromPoints(this.vertices[0].position,this.vertices[1].position,this.vertices[2].position); else return this.plane;
	}
	,__class__: thx_geom_Polygon
};
var thx_geom_Spline = function(nodes,closed) {
	if(closed == null) closed = true;
	this.nodes = nodes;
	this.closed = closed;
};
thx_geom_Spline.__name__ = ["thx","geom","Spline"];
thx_geom_Spline.fromPoints = function(arr,closed) {
	var nodes = arr.map(function(c) {
		return new thx_geom_SplineNode(c[0],c[1],c[2]);
	});
	return new thx_geom_Spline(nodes,closed);
};
thx_geom_Spline.fromArray = function(arr,closed) {
	var nodes = arr.map(function(c) {
		return new thx_geom_SplineNode(c,null,null);
	});
	return new thx_geom_Spline(nodes,closed);
};
thx_geom_Spline.fromCoords = function(arr,closed) {
	var nodes = arr.map(function(c) {
		var p = [c[0],c[1]];
		var nout;
		if(null == c[2]) nout = thx_geom__$Point_Point_$Impl_$.zero; else nout = [c[2],c[3]];
		var nin;
		if(null == c[4]) nin = thx_geom__$Point_Point_$Impl_$.zero; else nin = [c[4],c[5]];
		return new thx_geom_SplineNode(p,nout,nin);
	});
	return new thx_geom_Spline(nodes,closed);
};
thx_geom_Spline.prototype = {
	area: null
	,length: null
	,isSelfIntersecting: null
	,isPolygon: null
	,box: null
	,edges: null
	,nodes: null
	,closed: null
	,iterator: function() {
		return HxOverrides.iter(this.nodes);
	}
	,iterate: function(fstart,fit) {
		var a;
		var b;
		if(null != fstart) fstart(this.nodes[0].point);
		var _g1 = 0;
		var _g = this.nodes.length - 1;
		while(_g1 < _g) {
			var i = _g1++;
			a = this.nodes[i];
			b = this.nodes[i + 1];
			fit(a.point,b.point,a.normalOut,b.normalIn);
		}
		if(this.closed) {
			a = this.nodes[this.nodes.length - 1];
			b = this.nodes[0];
			fit(a.point,b.point,a.normalOut,b.normalIn);
		}
	}
	,iterateEdges: function(f) {
		var _g = this;
		if(null != this.edges) this.edges.map(f); else {
			this.edges = [];
			this.iterate(null,function(a,b,nout,nin) {
				var side = new thx_geom_Edge(new thx_geom_Vertex(a,nout),new thx_geom_Vertex(b,nin));
				_g.edges.push(side);
				f(side);
			});
		}
	}
	,transform: function(matrix) {
		var ismirror = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.isMirroring(matrix);
		var result = new thx_geom_Spline(thx_core_Iterators.map(this.iterator(),function(node) {
			return node.transform(matrix);
		}),this.closed);
		if(ismirror) result = result.flip();
		return result;
	}
	,flip: function() {
		var arr = thx_core_Iterators.map(this.iterator(),function(node) {
			return node.flip();
		});
		arr.reverse();
		return new thx_geom_Spline(arr,this.closed);
	}
	,get_area: function() {
		var _g = this;
		if(null == this.area) {
			this.area = 0;
			this.iterateEdges(function(edge) {
				_g.area += edge.get_area();
			});
		}
		return this.area;
	}
	,get_length: function() {
		var _g = this;
		if(null == this.length) {
			this.length = 0;
			this.iterateEdges(function(edge) {
				if(null == edge.length) edge.length = Math.sqrt(edge.get_lengthSquared());
				_g.length += edge.length;
			});
		}
		return this.length;
	}
	,get_isSelfIntersecting: function() {
		return false;
	}
	,get_isPolygon: function() {
		return false;
	}
	,get_box: function() {
		var _g = this;
		if(null == this.box) {
			if(this.nodes.length > 0) {
				this.box = [this.nodes[0].point,this.nodes[0].point];
				this.iterate(null,function(a,b,nout,nin) {
					_g.box = thx_geom_shape__$Box_Box_$Impl_$.expandByPoints(_g.get_box(),[a,b,nout,nin]);
				});
			}
		}
		return this.box;
	}
	,contains: function(p) {
		throw "not implemented";
	}
	,intersectionsWithSpline: function(other) {
		throw "not implemented";
	}
	,intersectionsWithLine: function(line) {
		throw "not implemented";
	}
	,at: function(distance) {
		throw "not implemented";
	}
	,interpolate: function(distance) {
		throw "not implemented";
	}
	,tangent: function(distance) {
		throw "not implemented";
	}
	,interpolateTangent: function(distance) {
		throw "not implemented";
	}
	,toString: function() {
		return "Spline(" + this.nodes.map(function(n) {
			return "[" + n.toStringValues() + "]";
		}).join(", ") + "," + Std.string(this.closed) + ")";
	}
	,__class__: thx_geom_Spline
};
var thx_geom_SplineNode = function(point,normalout,normalin) {
	this.point = point;
	this.normalOut = normalout;
	this.normalIn = normalin;
};
thx_geom_SplineNode.__name__ = ["thx","geom","SplineNode"];
thx_geom_SplineNode.prototype = {
	point: null
	,normalIn: null
	,normalOut: null
	,transform: function(matrix) {
		return new thx_geom_SplineNode(thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint(matrix,this.point),thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint(matrix,this.normalIn),thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint(matrix,this.normalOut));
	}
	,flip: function() {
		return new thx_geom_SplineNode(this.point,this.normalIn,this.normalOut);
	}
	,toStringValues: function() {
		var nout;
		if(null == this.normalOut) nout = "null"; else nout = "" + this.normalOut[1] + "," + this.normalOut[1];
		var nin;
		if(null == this.normalIn) nin = "null"; else nin = "" + this.normalIn[1] + "," + this.normalIn[1];
		return "" + this.point[0] + "," + this.point[1] + "," + nout + "," + nin;
	}
	,toString: function() {
		return "SplineNode(" + this.toStringValues() + ")";
	}
	,__class__: thx_geom_SplineNode
};
var thx_geom_TestEdge = function() {
};
thx_geom_TestEdge.__name__ = ["thx","geom","TestEdge"];
thx_geom_TestEdge.prototype = {
	testLinearEdge: function() {
	}
	,testNonLinearEdge: function() {
	}
	,testCross: function() {
	}
	,testDoesntCross: function() {
	}
	,testAreaLinear: function() {
	}
	,testAreaNonLinear: function() {
	}
	,testLengthLinear: function() {
	}
	,testLengthNonLinear: function() {
	}
	,testIntersectionsWithEdge: function() {
	}
	,testIntersectionsWithLine: function() {
	}
	,__class__: thx_geom_TestEdge
};
var thx_geom_TestLine = function() {
};
thx_geom_TestLine.__name__ = ["thx","geom","TestLine"];
thx_geom_TestLine.prototype = {
	testXAtY: function() {
	}
	,testAbsDistanceToPoint: function() {
	}
	,testIntersectWithLine: function() {
	}
	,__class__: thx_geom_TestLine
};
var thx_geom_TestPoint = function() {
};
thx_geom_TestPoint.__name__ = ["thx","geom","TestPoint"];
thx_geom_TestPoint.prototype = {
	testInterpolate: function() {
		var a = [10,20];
		var b = [20,40];
		utest_Assert.isTrue(!(a[0] == b[0] && a[1] == b[1]),null,{ fileName : "TestPoint.hx", lineNumber : 15, className : "thx.geom.TestPoint", methodName : "testInterpolate"});
		utest_Assert.isTrue((function($this) {
			var $r;
			var this1 = thx_geom__$Point_Point_$Impl_$.interpolate(a,b,0);
			$r = this1[0] == a[0] && this1[1] == a[1];
			return $r;
		}(this)),null,{ fileName : "TestPoint.hx", lineNumber : 16, className : "thx.geom.TestPoint", methodName : "testInterpolate"});
		utest_Assert.isTrue((function($this) {
			var $r;
			var this2 = thx_geom__$Point_Point_$Impl_$.interpolate(a,b,1);
			$r = this2[0] == b[0] && this2[1] == b[1];
			return $r;
		}(this)),null,{ fileName : "TestPoint.hx", lineNumber : 17, className : "thx.geom.TestPoint", methodName : "testInterpolate"});
		utest_Assert.isTrue((function($this) {
			var $r;
			var this3 = thx_geom__$Point_Point_$Impl_$.interpolate(a,b,0.5);
			var p_0 = 15;
			var p_1 = 30;
			$r = this3[0] == p_0 && this3[1] == p_1;
			return $r;
		}(this)),null,{ fileName : "TestPoint.hx", lineNumber : 18, className : "thx.geom.TestPoint", methodName : "testInterpolate"});
	}
	,testLength: function() {
		var a_0 = 10;
		var a_1 = 20;
		utest_Assert.equals(Math.sqrt(500),Math.sqrt(a_0 * a_0 + a_1 * a_1),null,{ fileName : "TestPoint.hx", lineNumber : 23, className : "thx.geom.TestPoint", methodName : "testLength"});
	}
	,testNormalize: function() {
		var a = [2,0];
		utest_Assert.equals(1,(function($this) {
			var $r;
			var this1;
			{
				var v = Math.sqrt(a[0] * a[0] + a[1] * a[1]);
				this1 = [a[0] / v,a[1] / v];
			}
			$r = this1[0];
			return $r;
		}(this)),null,{ fileName : "TestPoint.hx", lineNumber : 28, className : "thx.geom.TestPoint", methodName : "testNormalize"});
		utest_Assert.equals(0,(function($this) {
			var $r;
			var this2;
			{
				var v1 = Math.sqrt(a[0] * a[0] + a[1] * a[1]);
				this2 = [a[0] / v1,a[1] / v1];
			}
			$r = this2[1];
			return $r;
		}(this)),null,{ fileName : "TestPoint.hx", lineNumber : 29, className : "thx.geom.TestPoint", methodName : "testNormalize"});
		a = [0,5];
		utest_Assert.equals(0,(function($this) {
			var $r;
			var this3;
			{
				var v2 = Math.sqrt(a[0] * a[0] + a[1] * a[1]);
				this3 = [a[0] / v2,a[1] / v2];
			}
			$r = this3[0];
			return $r;
		}(this)),null,{ fileName : "TestPoint.hx", lineNumber : 31, className : "thx.geom.TestPoint", methodName : "testNormalize"});
		utest_Assert.equals(1,(function($this) {
			var $r;
			var this4;
			{
				var v3 = Math.sqrt(a[0] * a[0] + a[1] * a[1]);
				this4 = [a[0] / v3,a[1] / v3];
			}
			$r = this4[1];
			return $r;
		}(this)),null,{ fileName : "TestPoint.hx", lineNumber : 32, className : "thx.geom.TestPoint", methodName : "testNormalize"});
	}
	,testDistanceTo: function() {
	}
	,testPointAt: function() {
	}
	,testToAngle: function() {
	}
	,testFromAngle: function() {
		var p;
		var angle = 90 / thx_unit_angle_Const.TO_DEGREE;
		var x = Math.cos(angle);
		var y = Math.sin(angle);
		p = [x,y];
		utest_Assert.isTrue(thx_geom__$Point_Point_$Impl_$.nearEquals([0,1],p),null,{ fileName : "TestPoint.hx", lineNumber : 50, className : "thx.geom.TestPoint", methodName : "testFromAngle"});
	}
	,__class__: thx_geom_TestPoint
};
var thx_geom_TestPoint3D = function() {
};
thx_geom_TestPoint3D.__name__ = ["thx","geom","TestPoint3D"];
thx_geom_TestPoint3D.prototype = {
	testInterpolate3D: function() {
		var a = [10,20,30];
		var b = [20,40,60];
		utest_Assert.isTrue(!thx_geom__$Point3D_Point3D_$Impl_$.equals(a,b),null,{ fileName : "TestPoint3D.hx", lineNumber : 13, className : "thx.geom.TestPoint3D", methodName : "testInterpolate3D"});
		utest_Assert.isTrue(thx_geom__$Point3D_Point3D_$Impl_$.equals(thx_geom__$Point3D_Point3D_$Impl_$.interpolate(a,b,0),a),null,{ fileName : "TestPoint3D.hx", lineNumber : 14, className : "thx.geom.TestPoint3D", methodName : "testInterpolate3D"});
		utest_Assert.isTrue(thx_geom__$Point3D_Point3D_$Impl_$.equals(thx_geom__$Point3D_Point3D_$Impl_$.interpolate(a,b,1),b),null,{ fileName : "TestPoint3D.hx", lineNumber : 15, className : "thx.geom.TestPoint3D", methodName : "testInterpolate3D"});
		utest_Assert.isTrue(thx_geom__$Point3D_Point3D_$Impl_$.equals(thx_geom__$Point3D_Point3D_$Impl_$.interpolate(a,b,0.5),[15,30,45]),null,{ fileName : "TestPoint3D.hx", lineNumber : 16, className : "thx.geom.TestPoint3D", methodName : "testInterpolate3D"});
	}
	,__class__: thx_geom_TestPoint3D
};
var thx_geom_TestSpline = function() {
};
thx_geom_TestSpline.__name__ = ["thx","geom","TestSpline"];
thx_geom_TestSpline.prototype = {
	testLength: function() {
	}
	,testBox: function() {
	}
	,testArea: function() {
	}
	,testIsSelfIntersecting: function() {
	}
	,testIsNotSelfIntersecting: function() {
	}
	,testIsPolygon: function() {
	}
	,testIsNotPolygon: function() {
	}
	,testAt: function() {
	}
	,testInterpolate: function() {
	}
	,testIntersection: function() {
	}
	,testTangent: function() {
	}
	,testInterpolateTangent: function() {
	}
	,testContains: function() {
	}
	,__class__: thx_geom_TestSpline
};
var thx_geom_Vertex = function(position,normal) {
	this.position = position;
	this.normal = normal;
};
thx_geom_Vertex.__name__ = ["thx","geom","Vertex"];
thx_geom_Vertex.linearVertex = function(position) {
	return new thx_geom_Vertex(position,thx_geom__$Point_Point_$Impl_$.zero);
};
thx_geom_Vertex.getLengthSquaredIntegrand = function(v) {
	var p1x = v[0];
	var p1y = v[1];
	var c1x = v[2];
	var c1y = v[3];
	var c2x = v[4];
	var c2y = v[5];
	var p2x = v[6];
	var p2y = v[7];
	var ax = 9 * (c1x - c2x) + 3 * (p2x - p1x);
	var bx = 6 * (p1x + c2x) - 12 * c1x;
	var cx = 3 * (c1x - p1x);
	var ay = 9 * (c1y - c2y) + 3 * (p2y - p1y);
	var by = 6 * (p1y + c2y) - 12 * c1y;
	var cy = 3 * (c1y - p1y);
	return function(t) {
		var dx = (ax * t + bx) * t + cx;
		var dy = (ay * t + by) * t + cy;
		return dx * dx + dy * dy;
	};
};
thx_geom_Vertex.prototype = {
	position: null
	,normal: null
	,flip: function() {
		return new thx_geom_Vertex(this.position,(function($this) {
			var $r;
			var this1 = $this.normal;
			$r = [-this1[0],-this1[1]];
			return $r;
		}(this)));
	}
	,interpolate: function(other,t) {
		return new thx_geom_Vertex(thx_geom__$Point_Point_$Impl_$.interpolate(this.position,other.position,t),thx_geom__$Point_Point_$Impl_$.interpolate(this.normal,other.normal,t));
	}
	,getDistanceSquared: function(other) {
		var v = [this.position[0],this.position[1],this.position[0] + this.normal[0],this.position[1] + this.normal[1],other.position[0] + other.normal[0],other.position[1] + other.normal[1],other.position[0],other.position[1]];
		if(Math.abs(v[0] - v[2]) <= 10e-10 && Math.abs(v[1] - v[3]) <= 10e-10 && Math.abs(v[6] - v[4]) <= 10e-10 && Math.abs(v[7] - v[5]) <= 10e-10) return thx_geom__$Point_Point_$Impl_$.distanceToSquared(this.position,other.position);
		return thx_math_Number.integrate(thx_geom_Vertex.getLengthSquaredIntegrand(v),0,1,16);
	}
	,getDistance: function(other) {
		return Math.sqrt(this.getDistanceSquared(other));
	}
	,transform: function(matrix) {
		return new thx_geom_Vertex(thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint(matrix,this.position),thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint(matrix,this.normal));
	}
	,equals: function(other) {
		return (function($this) {
			var $r;
			var this1 = $this.position;
			var p = other.position;
			$r = this1[0] == p[0] && this1[1] == p[1];
			return $r;
		}(this)) && (function($this) {
			var $r;
			var this2 = $this.normal;
			var p1 = other.normal;
			$r = this2[0] == p1[0] && this2[1] == p1[1];
			return $r;
		}(this));
	}
	,toString: function() {
		return "Vertex(" + (function($this) {
			var $r;
			var this1 = $this.position;
			$r = "Point(" + this1[0] + "," + this1[1] + ")";
			return $r;
		}(this)) + "," + (function($this) {
			var $r;
			var this2 = $this.normal;
			$r = "Point(" + this2[0] + "," + this2[1] + ")";
			return $r;
		}(this)) + ")";
	}
	,__class__: thx_geom_Vertex
};
var thx_geom_Vertex3D = function(position,normal) {
	this.position = position;
	this.normal = normal;
};
thx_geom_Vertex3D.__name__ = ["thx","geom","Vertex3D"];
thx_geom_Vertex3D.prototype = {
	position: null
	,normal: null
	,flip: function() {
		return new thx_geom_Vertex3D(this.position,(function($this) {
			var $r;
			var this1 = $this.normal;
			$r = [-this1[0],-this1[1],-this1[2]];
			return $r;
		}(this)));
	}
	,interpolate: function(other,t) {
		return new thx_geom_Vertex3D(thx_geom__$Point3D_Point3D_$Impl_$.interpolate(this.position,other.position,t),thx_geom__$Point3D_Point3D_$Impl_$.interpolate(this.normal,other.normal,t));
	}
	,transform: function(matrix) {
		return new thx_geom_Vertex3D((function($this) {
			var $r;
			var this1 = $this.position;
			$r = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint3D(matrix,[this1[0],this1[1],this1[2]]);
			return $r;
		}(this)),(function($this) {
			var $r;
			var this2 = $this.normal;
			$r = thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.leftMultiplyPoint3D(matrix,[this2[0],this2[1],this2[2]]);
			return $r;
		}(this)));
	}
	,toString: function() {
		return "Vertex3D " + (function($this) {
			var $r;
			var this1 = $this.position;
			$r = "Point3D(" + this1[0] + "," + this1[1] + "," + this1[2] + ")";
			return $r;
		}(this)) + ", " + (function($this) {
			var $r;
			var this2 = $this.normal;
			$r = "Point3D(" + this2[0] + "," + this2[1] + "," + this2[2] + ")";
			return $r;
		}(this));
	}
	,__class__: thx_geom_Vertex3D
};
var thx_geom_shape__$Box_Box_$Impl_$ = function() { };
thx_geom_shape__$Box_Box_$Impl_$.__name__ = ["thx","geom","shape","_Box","Box_Impl_"];
thx_geom_shape__$Box_Box_$Impl_$.fromPoints = function(a,b) {
	var bottomLeft;
	var x = Math.min(a[0],b[0]);
	var y = Math.min(a[1],b[1]);
	bottomLeft = [x,y];
	var topRight;
	var x1 = Math.max(a[0],b[0]);
	var y1 = Math.max(a[1],b[1]);
	topRight = [x1,y1];
	return [bottomLeft,topRight];
};
thx_geom_shape__$Box_Box_$Impl_$._new = function(bottomLeft,topRight) {
	return [bottomLeft,topRight];
};
thx_geom_shape__$Box_Box_$Impl_$.get_topLeft = function(this1) {
	return [this1[0][0],this1[1][1]];
};
thx_geom_shape__$Box_Box_$Impl_$.get_topRight = function(this1) {
	return this1[1];
};
thx_geom_shape__$Box_Box_$Impl_$.get_bottomLeft = function(this1) {
	return this1[0];
};
thx_geom_shape__$Box_Box_$Impl_$.get_bottomRight = function(this1) {
	return [this1[1][0],this1[0][1]];
};
thx_geom_shape__$Box_Box_$Impl_$.get_center = function(this1) {
	return [this1[0][0] + (this1[1][0] - this1[0][0]) / 2,this1[1][1] + (this1[1][1] - this1[0][1]) / 2];
};
thx_geom_shape__$Box_Box_$Impl_$.get_left = function(this1) {
	return this1[0][0];
};
thx_geom_shape__$Box_Box_$Impl_$.get_right = function(this1) {
	return this1[1][0];
};
thx_geom_shape__$Box_Box_$Impl_$.get_top = function(this1) {
	return this1[1][1];
};
thx_geom_shape__$Box_Box_$Impl_$.get_bottom = function(this1) {
	return this1[0][1];
};
thx_geom_shape__$Box_Box_$Impl_$.get_width = function(this1) {
	return this1[1][0] - this1[0][0];
};
thx_geom_shape__$Box_Box_$Impl_$.get_height = function(this1) {
	return this1[1][1] - this1[0][1];
};
thx_geom_shape__$Box_Box_$Impl_$.expandByPoint = function(this1,point) {
	var bottomLeft;
	var this2 = this1[0];
	var x = Math.min(this2[0],point[0]);
	var y = Math.min(this2[1],point[1]);
	bottomLeft = [x,y];
	var topRight;
	var this3 = this1[1];
	var x1 = Math.max(this3[0],point[0]);
	var y1 = Math.max(this3[1],point[1]);
	topRight = [x1,y1];
	return [bottomLeft,topRight];
};
thx_geom_shape__$Box_Box_$Impl_$.expandByPoints = function(this1,points) {
	var min = this1[0];
	var max = this1[1];
	var $it0 = $iterator(points)();
	while( $it0.hasNext() ) {
		var point = $it0.next();
		var x = Math.min(min[0],point[0]);
		var y = Math.min(min[1],point[1]);
		min = [x,y];
		var x1 = Math.max(max[0],point[0]);
		var y1 = Math.max(max[1],point[1]);
		max = [x1,y1];
	}
	return [min,max];
};
thx_geom_shape__$Box_Box_$Impl_$.equals = function(this1,other) {
	return (function($this) {
		var $r;
		var this2 = this1[0];
		var p = other[0];
		$r = this2[0] == p[0] && this2[1] == p[1];
		return $r;
	}(this)) && (function($this) {
		var $r;
		var this3 = this1[1];
		var p1 = other[1];
		$r = this3[0] == p1[0] && this3[1] == p1[1];
		return $r;
	}(this));
};
thx_geom_shape__$Box_Box_$Impl_$.toString = function(this1) {
	return "Box(x:" + this1[0][0] + ",y:" + this1[1][1] + ",w:" + (this1[1][0] - this1[0][0]) + ",h:" + (this1[1][1] - this1[0][1]) + ")";
};
thx_geom_shape__$Box_Box_$Impl_$.toSpline = function(this1) {
	return thx_geom_Spline.fromArray([[this1[0][0],this1[1][1]],this1[1],[this1[1][0],this1[0][1]],this1[0]],true);
};
var thx_geom_shape__$Circle_Circle_$Impl_$ = function() { };
thx_geom_shape__$Circle_Circle_$Impl_$.__name__ = ["thx","geom","shape","_Circle","Circle_Impl_"];
thx_geom_shape__$Circle_Circle_$Impl_$._new = function(center,radius) {
	return { center : center, radius : radius};
};
thx_geom_shape__$Circle_Circle_$Impl_$.get_center = function(this1) {
	return this1.center;
};
thx_geom_shape__$Circle_Circle_$Impl_$.get_radius = function(this1) {
	return this1.radius;
};
thx_geom_shape__$Circle_Circle_$Impl_$.toString = function(this1) {
	return "Circle(" + this1.center[0] + "," + this1.center[1] + "," + this1.radius + ")";
};
thx_geom_shape__$Circle_Circle_$Impl_$.toSpline = function(this1) {
	var segments = 32;
	var angle = Math.PI / segments;
	var points = [];
	var nodes = [];
	var j;
	var _g1 = 0;
	var _g = segments * 2;
	while(_g1 < _g) {
		var i = _g1++;
		points.push(thx_geom__$Point_Point_$Impl_$.pointAt(this1.center,angle * i,this1.radius));
	}
	nodes.push(new thx_geom_SplineNode(points[0],points[1],points[points.length - 1]));
	var _g11 = 1;
	var _g2 = segments - 1;
	while(_g11 < _g2) {
		var i1 = _g11++;
		j = i1 * 2;
		nodes.push(new thx_geom_SplineNode(points[j],points[j + 1],points[j - 1]));
	}
	nodes.push(new thx_geom_SplineNode(points[points.length - 2],points[points.length - 1],points[points.length - 3]));
	return new thx_geom_Spline(nodes,true);
};
var thx_math_Number = function() { };
thx_math_Number.__name__ = ["thx","math","Number"];
thx_math_Number.isNearZero = function(n) {
	return Math.abs(n) <= 10e-10;
};
thx_math_Number.integrate = function(f,a,b,n) {
	var x = thx_math_Number.abscissas[n - 2];
	var w = thx_math_Number.weights[n - 2];
	var A = 0.5 * (b - a);
	var B = A + a;
	var i = 0;
	var m = n + 1 >> 1;
	var sum;
	if((n & 1) == 1) sum = w[i++] * f(B); else sum = 0;
	var Ax;
	while(i < m) {
		Ax = A * x[i];
		sum += w[i++] * (f(B + Ax) + f(B - Ax));
	}
	return A * sum;
};
var thx_unit_angle_Const = function() { };
thx_unit_angle_Const.__name__ = ["thx","unit","angle","Const"];
var thx_unit_angle__$Degree_Degree_$Impl_$ = function() { };
thx_unit_angle__$Degree_Degree_$Impl_$.__name__ = ["thx","unit","angle","_Degree","Degree_Impl_"];
thx_unit_angle__$Degree_Degree_$Impl_$.fromFloat = function(angle) {
	return angle;
};
thx_unit_angle__$Degree_Degree_$Impl_$._new = function(degrees) {
	return degrees;
};
thx_unit_angle__$Degree_Degree_$Impl_$.cos = function(this1) {
	return Math.cos(this1 / thx_unit_angle_Const.TO_DEGREE);
};
thx_unit_angle__$Degree_Degree_$Impl_$.sin = function(this1) {
	return Math.sin(this1 / thx_unit_angle_Const.TO_DEGREE);
};
thx_unit_angle__$Degree_Degree_$Impl_$.toString = function(this1) {
	return "" + this1 + "̊";
};
thx_unit_angle__$Degree_Degree_$Impl_$.toRadians = function(this1) {
	return this1 / thx_unit_angle_Const.TO_DEGREE;
};
thx_unit_angle__$Degree_Degree_$Impl_$.toFloat = function(this1) {
	return this1;
};
thx_unit_angle__$Degree_Degree_$Impl_$.negate = function(this1) {
	return -this1;
};
thx_unit_angle__$Degree_Degree_$Impl_$.multiply = function(this1,v) {
	return this1 * v;
};
thx_unit_angle__$Degree_Degree_$Impl_$.divide = function(this1,v) {
	return this1 / v;
};
thx_unit_angle__$Degree_Degree_$Impl_$.add = function(this1,r) {
	return this1 + r;
};
thx_unit_angle__$Degree_Degree_$Impl_$.addFloat = function(this1,v) {
	return this1 + v;
};
thx_unit_angle__$Degree_Degree_$Impl_$.subtract = function(this1,r) {
	return this1 + -r;
};
thx_unit_angle__$Degree_Degree_$Impl_$.subtractFloat = function(this1,v) {
	return this1 + -v;
};
thx_unit_angle__$Degree_Degree_$Impl_$.equals = function(this1,v) {
	return this1 == v;
};
var thx_unit_angle_FloatDegree = function() { };
thx_unit_angle_FloatDegree.__name__ = ["thx","unit","angle","FloatDegree"];
thx_unit_angle_FloatDegree.toDegrees = function(v) {
	return v;
};
var thx_unit_angle__$Radian_Radian_$Impl_$ = function() { };
thx_unit_angle__$Radian_Radian_$Impl_$.__name__ = ["thx","unit","angle","_Radian","Radian_Impl_"];
thx_unit_angle__$Radian_Radian_$Impl_$.fromFloat = function(angle) {
	return angle;
};
thx_unit_angle__$Radian_Radian_$Impl_$._new = function(radians) {
	return radians;
};
thx_unit_angle__$Radian_Radian_$Impl_$.cos = function(this1) {
	return Math.cos(this1);
};
thx_unit_angle__$Radian_Radian_$Impl_$.sin = function(this1) {
	return Math.sin(this1);
};
thx_unit_angle__$Radian_Radian_$Impl_$.toString = function(this1) {
	return "" + this1 + "rad";
};
thx_unit_angle__$Radian_Radian_$Impl_$.toDegrees = function(this1) {
	return this1 * thx_unit_angle_Const.TO_DEGREE;
};
thx_unit_angle__$Radian_Radian_$Impl_$.toFloat = function(this1) {
	return this1;
};
thx_unit_angle__$Radian_Radian_$Impl_$.negate = function(this1) {
	return -this1;
};
thx_unit_angle__$Radian_Radian_$Impl_$.multiply = function(this1,v) {
	return this1 * v;
};
thx_unit_angle__$Radian_Radian_$Impl_$.divide = function(this1,v) {
	return this1 / v;
};
thx_unit_angle__$Radian_Radian_$Impl_$.add = function(this1,r) {
	return this1 + r;
};
thx_unit_angle__$Radian_Radian_$Impl_$.addFloat = function(this1,v) {
	return this1 + v;
};
thx_unit_angle__$Radian_Radian_$Impl_$.subtract = function(this1,r) {
	return this1 + -r;
};
thx_unit_angle__$Radian_Radian_$Impl_$.subtractFloat = function(this1,v) {
	return this1 + -v;
};
thx_unit_angle__$Radian_Radian_$Impl_$.equals = function(this1,v) {
	return this1 == v;
};
var thx_unit_angle_FloatRadian = function() { };
thx_unit_angle_FloatRadian.__name__ = ["thx","unit","angle","FloatRadian"];
thx_unit_angle_FloatRadian.toRadians = function(v) {
	return v;
};
var utest_Assert = function() { };
utest_Assert.__name__ = ["utest","Assert"];
utest_Assert.isTrue = function(cond,msg,pos) {
	if(utest_Assert.results == null) throw "Assert.results is not currently bound to any assert context";
	if(null == msg) msg = "expected true";
	if(cond) utest_Assert.results.add(utest_Assertation.Success(pos)); else utest_Assert.results.add(utest_Assertation.Failure(msg,pos));
};
utest_Assert.isFalse = function(value,msg,pos) {
	if(null == msg) msg = "expected false";
	utest_Assert.isTrue(value == false,msg,pos);
};
utest_Assert.isNull = function(value,msg,pos) {
	if(msg == null) msg = "expected null but was " + utest_Assert.q(value);
	utest_Assert.isTrue(value == null,msg,pos);
};
utest_Assert.notNull = function(value,msg,pos) {
	if(null == msg) msg = "expected not null";
	utest_Assert.isTrue(value != null,msg,pos);
};
utest_Assert["is"] = function(value,type,msg,pos) {
	if(msg == null) msg = "expected type " + utest_Assert.typeToString(type) + " but was " + utest_Assert.typeToString(value);
	utest_Assert.isTrue(js_Boot.__instanceof(value,type),msg,pos);
};
utest_Assert.notEquals = function(expected,value,msg,pos) {
	if(msg == null) msg = "expected " + utest_Assert.q(expected) + " and testa value " + utest_Assert.q(value) + " should be different";
	utest_Assert.isFalse(expected == value,msg,pos);
};
utest_Assert.equals = function(expected,value,msg,pos) {
	if(msg == null) msg = "expected " + utest_Assert.q(expected) + " but was " + utest_Assert.q(value);
	utest_Assert.isTrue(expected == value,msg,pos);
};
utest_Assert.match = function(pattern,value,msg,pos) {
	if(msg == null) msg = "the value " + utest_Assert.q(value) + "does not match the provided pattern";
	utest_Assert.isTrue(pattern.match(value),msg,pos);
};
utest_Assert.floatEquals = function(expected,value,approx,msg,pos) {
	if(msg == null) msg = "expected " + utest_Assert.q(expected) + " but was " + utest_Assert.q(value);
	return utest_Assert.isTrue(utest_Assert._floatEquals(expected,value,approx),msg,pos);
};
utest_Assert._floatEquals = function(expected,value,approx) {
	if(isNaN(expected)) return isNaN(value); else if(isNaN(value)) return false; else if(!isFinite(expected) && !isFinite(value)) return expected > 0 == value > 0;
	if(null == approx) approx = 1e-5;
	return Math.abs(value - expected) < approx;
};
utest_Assert.getTypeName = function(v) {
	{
		var _g = Type["typeof"](v);
		switch(_g[1]) {
		case 0:
			return "[null]";
		case 1:
			return "Int";
		case 2:
			return "Float";
		case 3:
			return "Bool";
		case 5:
			return "function";
		case 6:
			var c = _g[2];
			return Type.getClassName(c);
		case 7:
			var e = _g[2];
			return Type.getEnumName(e);
		case 4:
			return "Object";
		case 8:
			return "Unknown";
		}
	}
};
utest_Assert.isIterable = function(v,isAnonym) {
	var fields;
	if(isAnonym) fields = Reflect.fields(v); else fields = Type.getInstanceFields(Type.getClass(v));
	if(!Lambda.has(fields,"iterator")) return false;
	return Reflect.isFunction(Reflect.field(v,"iterator"));
};
utest_Assert.isIterator = function(v,isAnonym) {
	var fields;
	if(isAnonym) fields = Reflect.fields(v); else fields = Type.getInstanceFields(Type.getClass(v));
	if(!Lambda.has(fields,"next") || !Lambda.has(fields,"hasNext")) return false;
	return Reflect.isFunction(Reflect.field(v,"next")) && Reflect.isFunction(Reflect.field(v,"hasNext"));
};
utest_Assert.sameAs = function(expected,value,status) {
	var texpected = utest_Assert.getTypeName(expected);
	var tvalue = utest_Assert.getTypeName(value);
	if(texpected != tvalue) {
		status.error = "expected type " + texpected + " but it is " + tvalue + (status.path == ""?"":" for field " + status.path);
		return false;
	}
	{
		var _g = Type["typeof"](expected);
		switch(_g[1]) {
		case 2:
			if(!utest_Assert._floatEquals(expected,value)) {
				status.error = "expected " + utest_Assert.q(expected) + " but it is " + utest_Assert.q(value) + (status.path == ""?"":" for field " + status.path);
				return false;
			}
			return true;
		case 0:case 1:case 3:
			if(expected != value) {
				status.error = "expected " + utest_Assert.q(expected) + " but it is " + utest_Assert.q(value) + (status.path == ""?"":" for field " + status.path);
				return false;
			}
			return true;
		case 5:
			if(!Reflect.compareMethods(expected,value)) {
				status.error = "expected same function reference" + (status.path == ""?"":" for field " + status.path);
				return false;
			}
			return true;
		case 6:
			var c = _g[2];
			var cexpected = Type.getClassName(c);
			var cvalue = Type.getClassName(Type.getClass(value));
			if(cexpected != cvalue) {
				status.error = "expected instance of " + utest_Assert.q(cexpected) + " but it is " + utest_Assert.q(cvalue) + (status.path == ""?"":" for field " + status.path);
				return false;
			}
			if(typeof(expected) == "string" && expected != value) {
				status.error = "expected '" + Std.string(expected) + "' but it is '" + Std.string(value) + "'";
				return false;
			}
			if((expected instanceof Array) && expected.__enum__ == null) {
				if(status.recursive || status.path == "") {
					if(expected.length != value.length) {
						status.error = "expected " + Std.string(expected.length) + " elements but they were " + Std.string(value.length) + (status.path == ""?"":" for field " + status.path);
						return false;
					}
					var path = status.path;
					var _g2 = 0;
					var _g1 = expected.length;
					while(_g2 < _g1) {
						var i = _g2++;
						if(path == "") status.path = "array[" + i + "]"; else status.path = path + "[" + i + "]";
						if(!utest_Assert.sameAs(expected[i],value[i],status)) {
							status.error = "expected " + utest_Assert.q(expected) + " but it is " + utest_Assert.q(value) + (status.path == ""?"":" for field " + status.path);
							return false;
						}
					}
				}
				return true;
			}
			if(js_Boot.__instanceof(expected,Date)) {
				if(expected.getTime() != value.getTime()) {
					status.error = "expected " + utest_Assert.q(expected) + " but it is " + utest_Assert.q(value) + (status.path == ""?"":" for field " + status.path);
					return false;
				}
				return true;
			}
			if(js_Boot.__instanceof(expected,haxe_io_Bytes)) {
				if(status.recursive || status.path == "") {
					var ebytes = expected;
					var vbytes = value;
					if(ebytes.length != vbytes.length) return false;
					var _g21 = 0;
					var _g11 = ebytes.length;
					while(_g21 < _g11) {
						var i1 = _g21++;
						if(ebytes.b[i1] != vbytes.b[i1]) {
							status.error = "expected byte " + ebytes.b[i1] + " but wss " + ebytes.b[i1] + (status.path == ""?"":" for field " + status.path);
							return false;
						}
					}
				}
				return true;
			}
			if(js_Boot.__instanceof(expected,haxe_ds_StringMap) || js_Boot.__instanceof(expected,haxe_ds_IntMap)) {
				if(status.recursive || status.path == "") {
					var keys = Lambda.array({ iterator : function() {
						return expected.keys();
					}});
					var vkeys = Lambda.array({ iterator : function() {
						return value.keys();
					}});
					if(keys.length != vkeys.length) {
						status.error = "expected " + keys.length + " keys but they were " + vkeys.length + (status.path == ""?"":" for field " + status.path);
						return false;
					}
					var path1 = status.path;
					var _g12 = 0;
					while(_g12 < keys.length) {
						var key = keys[_g12];
						++_g12;
						if(path1 == "") status.path = "hash[" + key + "]"; else status.path = path1 + "[" + key + "]";
						if(!utest_Assert.sameAs(expected.get(key),value.get(key),status)) {
							status.error = "expected " + utest_Assert.q(expected) + " but it is " + utest_Assert.q(value) + (status.path == ""?"":" for field " + status.path);
							return false;
						}
					}
				}
				return true;
			}
			if(utest_Assert.isIterator(expected,false)) {
				if(status.recursive || status.path == "") {
					var evalues = Lambda.array({ iterator : function() {
						return expected;
					}});
					var vvalues = Lambda.array({ iterator : function() {
						return value;
					}});
					if(evalues.length != vvalues.length) {
						status.error = "expected " + evalues.length + " values in Iterator but they were " + vvalues.length + (status.path == ""?"":" for field " + status.path);
						return false;
					}
					var path2 = status.path;
					var _g22 = 0;
					var _g13 = evalues.length;
					while(_g22 < _g13) {
						var i2 = _g22++;
						if(path2 == "") status.path = "iterator[" + i2 + "]"; else status.path = path2 + "[" + i2 + "]";
						if(!utest_Assert.sameAs(evalues[i2],vvalues[i2],status)) {
							status.error = "expected " + utest_Assert.q(expected) + " but it is " + utest_Assert.q(value) + (status.path == ""?"":" for field " + status.path);
							return false;
						}
					}
				}
				return true;
			}
			if(utest_Assert.isIterable(expected,false)) {
				if(status.recursive || status.path == "") {
					var evalues1 = Lambda.array(expected);
					var vvalues1 = Lambda.array(value);
					if(evalues1.length != vvalues1.length) {
						status.error = "expected " + evalues1.length + " values in Iterable but they were " + vvalues1.length + (status.path == ""?"":" for field " + status.path);
						return false;
					}
					var path3 = status.path;
					var _g23 = 0;
					var _g14 = evalues1.length;
					while(_g23 < _g14) {
						var i3 = _g23++;
						if(path3 == "") status.path = "iterable[" + i3 + "]"; else status.path = path3 + "[" + i3 + "]";
						if(!utest_Assert.sameAs(evalues1[i3],vvalues1[i3],status)) return false;
					}
				}
				return true;
			}
			if(status.recursive || status.path == "") {
				var fields = Type.getInstanceFields(Type.getClass(expected));
				var path4 = status.path;
				var _g15 = 0;
				while(_g15 < fields.length) {
					var field = fields[_g15];
					++_g15;
					if(path4 == "") status.path = field; else status.path = path4 + "." + field;
					var e = Reflect.field(expected,field);
					if(Reflect.isFunction(e)) continue;
					var v = Reflect.field(value,field);
					if(!utest_Assert.sameAs(e,v,status)) return false;
				}
			}
			return true;
		case 7:
			var e1 = _g[2];
			var eexpected = Type.getEnumName(e1);
			var evalue = Type.getEnumName(Type.getEnum(value));
			if(eexpected != evalue) {
				status.error = "expected enumeration of " + utest_Assert.q(eexpected) + " but it is " + utest_Assert.q(evalue) + (status.path == ""?"":" for field " + status.path);
				return false;
			}
			if(status.recursive || status.path == "") {
				if(Type.enumIndex(expected) != Type.enumIndex(value)) {
					status.error = "expected " + utest_Assert.q(Type.enumConstructor(expected)) + " but is " + utest_Assert.q(Type.enumConstructor(value)) + (status.path == ""?"":" for field " + status.path);
					return false;
				}
				var eparams = Type.enumParameters(expected);
				var vparams = Type.enumParameters(value);
				var path5 = status.path;
				var _g24 = 0;
				var _g16 = eparams.length;
				while(_g24 < _g16) {
					var i4 = _g24++;
					if(path5 == "") status.path = "enum[" + i4 + "]"; else status.path = path5 + "[" + i4 + "]";
					if(!utest_Assert.sameAs(eparams[i4],vparams[i4],status)) {
						status.error = "expected " + utest_Assert.q(expected) + " but it is " + utest_Assert.q(value) + (status.path == ""?"":" for field " + status.path);
						return false;
					}
				}
			}
			return true;
		case 4:
			if(status.recursive || status.path == "") {
				var tfields = Reflect.fields(value);
				var fields1 = Reflect.fields(expected);
				var path6 = status.path;
				var _g17 = 0;
				while(_g17 < fields1.length) {
					var field1 = fields1[_g17];
					++_g17;
					HxOverrides.remove(tfields,field1);
					if(path6 == "") status.path = field1; else status.path = path6 + "." + field1;
					if(!Object.prototype.hasOwnProperty.call(value,field1)) {
						status.error = "expected field " + status.path + " does not exist in " + utest_Assert.q(value);
						return false;
					}
					var e2 = Reflect.field(expected,field1);
					if(Reflect.isFunction(e2)) continue;
					var v1 = Reflect.field(value,field1);
					if(!utest_Assert.sameAs(e2,v1,status)) return false;
				}
				if(tfields.length > 0) {
					status.error = "the tested object has extra field(s) (" + tfields.join(", ") + ") not included in the expected ones";
					return false;
				}
			}
			if(utest_Assert.isIterator(expected,true)) {
				if(!utest_Assert.isIterator(value,true)) {
					status.error = "expected Iterable but it is not " + (status.path == ""?"":" for field " + status.path);
					return false;
				}
				if(status.recursive || status.path == "") {
					var evalues2 = Lambda.array({ iterator : function() {
						return expected;
					}});
					var vvalues2 = Lambda.array({ iterator : function() {
						return value;
					}});
					if(evalues2.length != vvalues2.length) {
						status.error = "expected " + evalues2.length + " values in Iterator but they were " + vvalues2.length + (status.path == ""?"":" for field " + status.path);
						return false;
					}
					var path7 = status.path;
					var _g25 = 0;
					var _g18 = evalues2.length;
					while(_g25 < _g18) {
						var i5 = _g25++;
						if(path7 == "") status.path = "iterator[" + i5 + "]"; else status.path = path7 + "[" + i5 + "]";
						if(!utest_Assert.sameAs(evalues2[i5],vvalues2[i5],status)) {
							status.error = "expected " + utest_Assert.q(expected) + " but it is " + utest_Assert.q(value) + (status.path == ""?"":" for field " + status.path);
							return false;
						}
					}
				}
				return true;
			}
			if(utest_Assert.isIterable(expected,true)) {
				if(!utest_Assert.isIterable(value,true)) {
					status.error = "expected Iterator but it is not " + (status.path == ""?"":" for field " + status.path);
					return false;
				}
				if(status.recursive || status.path == "") {
					var evalues3 = Lambda.array(expected);
					var vvalues3 = Lambda.array(value);
					if(evalues3.length != vvalues3.length) {
						status.error = "expected " + evalues3.length + " values in Iterable but they were " + vvalues3.length + (status.path == ""?"":" for field " + status.path);
						return false;
					}
					var path8 = status.path;
					var _g26 = 0;
					var _g19 = evalues3.length;
					while(_g26 < _g19) {
						var i6 = _g26++;
						if(path8 == "") status.path = "iterable[" + i6 + "]"; else status.path = path8 + "[" + i6 + "]";
						if(!utest_Assert.sameAs(evalues3[i6],vvalues3[i6],status)) return false;
					}
				}
				return true;
			}
			return true;
		case 8:
			throw "Unable to compare two unknown types";
			break;
		}
	}
	throw "Unable to compare values: " + utest_Assert.q(expected) + " and " + utest_Assert.q(value);
};
utest_Assert.q = function(v) {
	if(typeof(v) == "string") return "\"" + StringTools.replace(v,"\"","\\\"") + "\""; else return Std.string(v);
};
utest_Assert.same = function(expected,value,recursive,msg,pos) {
	var status = { recursive : null == recursive?true:recursive, path : "", error : null};
	if(utest_Assert.sameAs(expected,value,status)) utest_Assert.isTrue(true,msg,pos); else utest_Assert.fail(msg == null?status.error:msg,pos);
};
utest_Assert.raises = function(method,type,msgNotThrown,msgWrongType,pos) {
	if(type == null) type = String;
	try {
		method();
		var name = Type.getClassName(type);
		if(name == null) name = "" + Std.string(type);
		if(null == msgNotThrown) msgNotThrown = "exception of type " + name + " not raised";
		utest_Assert.fail(msgNotThrown,pos);
	} catch( ex ) {
		var name1 = Type.getClassName(type);
		if(name1 == null) name1 = "" + Std.string(type);
		if(null == msgWrongType) msgWrongType = "expected throw of type " + name1 + " but was " + Std.string(ex);
		utest_Assert.isTrue(js_Boot.__instanceof(ex,type),msgWrongType,pos);
	}
};
utest_Assert.allows = function(possibilities,value,msg,pos) {
	if(Lambda.has(possibilities,value)) utest_Assert.isTrue(true,msg,pos); else utest_Assert.fail(msg == null?"value " + utest_Assert.q(value) + " not found in the expected possibilities " + Std.string(possibilities):msg,pos);
};
utest_Assert.contains = function(match,values,msg,pos) {
	if(Lambda.has(values,match)) utest_Assert.isTrue(true,msg,pos); else utest_Assert.fail(msg == null?"values " + utest_Assert.q(values) + " do not contain " + Std.string(match):msg,pos);
};
utest_Assert.notContains = function(match,values,msg,pos) {
	if(!Lambda.has(values,match)) utest_Assert.isTrue(true,msg,pos); else utest_Assert.fail(msg == null?"values " + utest_Assert.q(values) + " do contain " + Std.string(match):msg,pos);
};
utest_Assert.stringContains = function(match,value,msg,pos) {
	if(value != null && value.indexOf(match) >= 0) utest_Assert.isTrue(true,msg,pos); else utest_Assert.fail(msg == null?"value " + utest_Assert.q(value) + " does not contain " + utest_Assert.q(match):msg,pos);
};
utest_Assert.stringSequence = function(sequence,value,msg,pos) {
	if(null == value) {
		utest_Assert.fail(msg == null?"null argument value":msg,pos);
		return;
	}
	var p = 0;
	var _g = 0;
	while(_g < sequence.length) {
		var s = sequence[_g];
		++_g;
		var p2 = value.indexOf(s,p);
		if(p2 < 0) {
			if(msg == null) {
				msg = "expected '" + s + "' after ";
				if(p > 0) {
					var cut = HxOverrides.substr(value,0,p);
					if(cut.length > 30) cut = "..." + HxOverrides.substr(cut,-27,null);
					msg += " '" + cut + "'";
				} else msg += " begin";
			}
			utest_Assert.fail(msg,pos);
			return;
		}
		p = p2 + s.length;
	}
	utest_Assert.isTrue(true,msg,pos);
};
utest_Assert.fail = function(msg,pos) {
	if(msg == null) msg = "failure expected";
	utest_Assert.isTrue(false,msg,pos);
};
utest_Assert.warn = function(msg) {
	utest_Assert.results.add(utest_Assertation.Warning(msg));
};
utest_Assert.createAsync = function(f,timeout) {
	return function() {
	};
};
utest_Assert.createEvent = function(f,timeout) {
	return function(e) {
	};
};
utest_Assert.typeToString = function(t) {
	try {
		var _t = Type.getClass(t);
		if(_t != null) t = _t;
	} catch( e ) {
	}
	try {
		return Type.getClassName(t);
	} catch( e1 ) {
	}
	try {
		var _t1 = Type.getEnum(t);
		if(_t1 != null) t = _t1;
	} catch( e2 ) {
	}
	try {
		return Type.getEnumName(t);
	} catch( e3 ) {
	}
	try {
		return Std.string(Type["typeof"](t));
	} catch( e4 ) {
	}
	try {
		return Std.string(t);
	} catch( e5 ) {
	}
	return "<unable to retrieve type name>";
};
var utest_Assertation = { __ename__ : ["utest","Assertation"], __constructs__ : ["Success","Failure","Error","SetupError","TeardownError","TimeoutError","AsyncError","Warning"] };
utest_Assertation.Success = function(pos) { var $x = ["Success",0,pos]; $x.__enum__ = utest_Assertation; return $x; };
utest_Assertation.Failure = function(msg,pos) { var $x = ["Failure",1,msg,pos]; $x.__enum__ = utest_Assertation; return $x; };
utest_Assertation.Error = function(e,stack) { var $x = ["Error",2,e,stack]; $x.__enum__ = utest_Assertation; return $x; };
utest_Assertation.SetupError = function(e,stack) { var $x = ["SetupError",3,e,stack]; $x.__enum__ = utest_Assertation; return $x; };
utest_Assertation.TeardownError = function(e,stack) { var $x = ["TeardownError",4,e,stack]; $x.__enum__ = utest_Assertation; return $x; };
utest_Assertation.TimeoutError = function(missedAsyncs,stack) { var $x = ["TimeoutError",5,missedAsyncs,stack]; $x.__enum__ = utest_Assertation; return $x; };
utest_Assertation.AsyncError = function(e,stack) { var $x = ["AsyncError",6,e,stack]; $x.__enum__ = utest_Assertation; return $x; };
utest_Assertation.Warning = function(msg) { var $x = ["Warning",7,msg]; $x.__enum__ = utest_Assertation; return $x; };
var utest__$Dispatcher_EventException = { __ename__ : ["utest","_Dispatcher","EventException"], __constructs__ : ["StopPropagation"] };
utest__$Dispatcher_EventException.StopPropagation = ["StopPropagation",0];
utest__$Dispatcher_EventException.StopPropagation.__enum__ = utest__$Dispatcher_EventException;
var utest_Dispatcher = function() {
	this.handlers = new Array();
};
utest_Dispatcher.__name__ = ["utest","Dispatcher"];
utest_Dispatcher.stop = function() {
	throw utest__$Dispatcher_EventException.StopPropagation;
};
utest_Dispatcher.prototype = {
	handlers: null
	,add: function(h) {
		this.handlers.push(h);
		return h;
	}
	,remove: function(h) {
		var _g1 = 0;
		var _g = this.handlers.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(Reflect.compareMethods(this.handlers[i],h)) return this.handlers.splice(i,1)[0];
		}
		return null;
	}
	,clear: function() {
		this.handlers = new Array();
	}
	,dispatch: function(e) {
		try {
			var list = this.handlers.slice();
			var _g = 0;
			while(_g < list.length) {
				var l = list[_g];
				++_g;
				l(e);
			}
			return true;
		} catch( exc ) {
			if( js_Boot.__instanceof(exc,utest__$Dispatcher_EventException) ) {
				return false;
			} else throw(exc);
		}
	}
	,has: function() {
		return this.handlers.length > 0;
	}
	,__class__: utest_Dispatcher
};
var utest_Notifier = function() {
	this.handlers = new Array();
};
utest_Notifier.__name__ = ["utest","Notifier"];
utest_Notifier.stop = function() {
	throw utest__$Dispatcher_EventException.StopPropagation;
};
utest_Notifier.prototype = {
	handlers: null
	,add: function(h) {
		this.handlers.push(h);
		return h;
	}
	,remove: function(h) {
		var _g1 = 0;
		var _g = this.handlers.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(Reflect.compareMethods(this.handlers[i],h)) return this.handlers.splice(i,1)[0];
		}
		return null;
	}
	,clear: function() {
		this.handlers = new Array();
	}
	,dispatch: function() {
		try {
			var list = this.handlers.slice();
			var _g = 0;
			while(_g < list.length) {
				var l = list[_g];
				++_g;
				l();
			}
			return true;
		} catch( exc ) {
			if( js_Boot.__instanceof(exc,utest__$Dispatcher_EventException) ) {
				return false;
			} else throw(exc);
		}
	}
	,has: function() {
		return this.handlers.length > 0;
	}
	,__class__: utest_Notifier
};
var utest_Runner = function() {
	this.fixtures = new Array();
	this.onProgress = new utest_Dispatcher();
	this.onStart = new utest_Dispatcher();
	this.onComplete = new utest_Dispatcher();
	this.length = 0;
};
utest_Runner.__name__ = ["utest","Runner"];
utest_Runner.prototype = {
	fixtures: null
	,onProgress: null
	,onStart: null
	,onComplete: null
	,length: null
	,addCase: function(test,setup,teardown,prefix,pattern) {
		if(prefix == null) prefix = "test";
		if(teardown == null) teardown = "teardown";
		if(setup == null) setup = "setup";
		if(!Reflect.isObject(test)) throw "can't add a null object as a test case";
		if(!this.isMethod(test,setup)) setup = null;
		if(!this.isMethod(test,teardown)) teardown = null;
		var fields = Type.getInstanceFields(Type.getClass(test));
		if(pattern == null) {
			var _g = 0;
			while(_g < fields.length) {
				var field = fields[_g];
				++_g;
				if(!StringTools.startsWith(field,prefix)) continue;
				if(!this.isMethod(test,field)) continue;
				this.addFixture(new utest_TestFixture(test,field,setup,teardown));
			}
		} else {
			var _g1 = 0;
			while(_g1 < fields.length) {
				var field1 = fields[_g1];
				++_g1;
				if(!pattern.match(field1)) continue;
				if(!this.isMethod(test,field1)) continue;
				this.addFixture(new utest_TestFixture(test,field1,setup,teardown));
			}
		}
	}
	,addFixture: function(fixture) {
		this.fixtures.push(fixture);
		this.length++;
	}
	,getFixture: function(index) {
		return this.fixtures[index];
	}
	,isMethod: function(test,name) {
		try {
			return Reflect.isFunction(Reflect.field(test,name));
		} catch( e ) {
			return false;
		}
	}
	,pos: null
	,run: function() {
		this.pos = 0;
		this.onStart.dispatch(this);
		this.runNext();
	}
	,runNext: function() {
		if(this.fixtures.length > this.pos) this.runFixture(this.fixtures[this.pos++]); else this.onComplete.dispatch(this);
	}
	,runFixture: function(fixture) {
		var handler = new utest_TestHandler(fixture);
		handler.onComplete.add($bind(this,this.testComplete));
		handler.execute();
	}
	,testComplete: function(h) {
		this.onProgress.dispatch({ result : utest_TestResult.ofHandler(h), done : this.pos, totals : this.length});
		this.runNext();
	}
	,__class__: utest_Runner
};
var utest_TestFixture = function(target,method,setup,teardown) {
	this.target = target;
	this.method = method;
	this.setup = setup;
	this.teardown = teardown;
};
utest_TestFixture.__name__ = ["utest","TestFixture"];
utest_TestFixture.prototype = {
	target: null
	,method: null
	,setup: null
	,teardown: null
	,checkMethod: function(name,arg) {
		var field = Reflect.field(this.target,name);
		if(field == null) throw arg + " function " + name + " is not a field of target";
		if(!Reflect.isFunction(field)) throw arg + " function " + name + " is not a function";
	}
	,__class__: utest_TestFixture
};
var utest_TestHandler = function(fixture) {
	if(fixture == null) throw "fixture argument is null";
	this.fixture = fixture;
	this.results = new List();
	this.asyncStack = new List();
	this.onTested = new utest_Dispatcher();
	this.onTimeout = new utest_Dispatcher();
	this.onComplete = new utest_Dispatcher();
};
utest_TestHandler.__name__ = ["utest","TestHandler"];
utest_TestHandler.exceptionStack = function(pops) {
	if(pops == null) pops = 2;
	var stack = haxe_CallStack.exceptionStack();
	while(pops-- > 0) stack.pop();
	return stack;
};
utest_TestHandler.prototype = {
	results: null
	,fixture: null
	,asyncStack: null
	,onTested: null
	,onTimeout: null
	,onComplete: null
	,execute: function() {
		try {
			this.executeMethod(this.fixture.setup);
			try {
				this.executeMethod(this.fixture.method);
			} catch( e ) {
				this.results.add(utest_Assertation.Error(e,utest_TestHandler.exceptionStack()));
			}
		} catch( e1 ) {
			this.results.add(utest_Assertation.SetupError(e1,utest_TestHandler.exceptionStack()));
		}
		this.checkTested();
	}
	,checkTested: function() {
		if(this.expireson == null || this.asyncStack.length == 0) this.tested(); else if(haxe_Timer.stamp() > this.expireson) this.timeout(); else haxe_Timer.delay($bind(this,this.checkTested),10);
	}
	,expireson: null
	,setTimeout: function(timeout) {
		var newexpire = haxe_Timer.stamp() + timeout / 1000;
		if(this.expireson == null) this.expireson = newexpire; else if(newexpire > this.expireson) this.expireson = newexpire; else this.expireson = this.expireson;
	}
	,bindHandler: function() {
		utest_Assert.results = this.results;
		utest_Assert.createAsync = $bind(this,this.addAsync);
		utest_Assert.createEvent = $bind(this,this.addEvent);
	}
	,unbindHandler: function() {
		utest_Assert.results = null;
		utest_Assert.createAsync = function(f,t) {
			return function() {
			};
		};
		utest_Assert.createEvent = function(f1,t1) {
			return function(e) {
			};
		};
	}
	,addAsync: function(f,timeout) {
		if(timeout == null) timeout = 250;
		if(null == f) f = function() {
		};
		this.asyncStack.add(f);
		var handler = this;
		this.setTimeout(timeout);
		return function() {
			if(!handler.asyncStack.remove(f)) {
				handler.results.add(utest_Assertation.AsyncError("async function already executed",[]));
				return;
			}
			try {
				handler.bindHandler();
				f();
			} catch( e ) {
				handler.results.add(utest_Assertation.AsyncError(e,utest_TestHandler.exceptionStack(0)));
			}
		};
	}
	,addEvent: function(f,timeout) {
		if(timeout == null) timeout = 250;
		this.asyncStack.add(f);
		var handler = this;
		this.setTimeout(timeout);
		return function(e) {
			if(!handler.asyncStack.remove(f)) {
				handler.results.add(utest_Assertation.AsyncError("event already executed",[]));
				return;
			}
			try {
				handler.bindHandler();
				f(e);
			} catch( e1 ) {
				handler.results.add(utest_Assertation.AsyncError(e1,utest_TestHandler.exceptionStack(0)));
			}
		};
	}
	,executeMethod: function(name) {
		if(name == null) return;
		this.bindHandler();
		Reflect.callMethod(this.fixture.target,Reflect.field(this.fixture.target,name),[]);
	}
	,tested: function() {
		if(this.results.length == 0) this.results.add(utest_Assertation.Warning("no assertions"));
		this.onTested.dispatch(this);
		this.completed();
	}
	,timeout: function() {
		this.results.add(utest_Assertation.TimeoutError(this.asyncStack.length,[]));
		this.onTimeout.dispatch(this);
		this.completed();
	}
	,completed: function() {
		try {
			this.executeMethod(this.fixture.teardown);
		} catch( e ) {
			this.results.add(utest_Assertation.TeardownError(e,utest_TestHandler.exceptionStack(2)));
		}
		this.unbindHandler();
		this.onComplete.dispatch(this);
	}
	,__class__: utest_TestHandler
};
var utest_TestResult = function() {
};
utest_TestResult.__name__ = ["utest","TestResult"];
utest_TestResult.ofHandler = function(handler) {
	var r = new utest_TestResult();
	var path = Type.getClassName(Type.getClass(handler.fixture.target)).split(".");
	r.cls = path.pop();
	r.pack = path.join(".");
	r.method = handler.fixture.method;
	r.setup = handler.fixture.setup;
	r.teardown = handler.fixture.teardown;
	r.assertations = handler.results;
	return r;
};
utest_TestResult.prototype = {
	pack: null
	,cls: null
	,method: null
	,setup: null
	,teardown: null
	,assertations: null
	,allOk: function() {
		try {
			var $it0 = this.assertations.iterator();
			while( $it0.hasNext() ) {
				var l = $it0.next();
				switch(l[1]) {
				case 0:
					throw "__break__";
					break;
				default:
					return false;
				}
			}
		} catch( e ) { if( e != "__break__" ) throw e; }
		return true;
	}
	,__class__: utest_TestResult
};
var utest_ui_Report = function() { };
utest_ui_Report.__name__ = ["utest","ui","Report"];
utest_ui_Report.create = function(runner,displaySuccessResults,headerDisplayMode) {
	var report;
	report = new utest_ui_text_PrintReport(runner);
	if(null == displaySuccessResults) report.displaySuccessResults = utest_ui_common_SuccessResultsDisplayMode.ShowSuccessResultsWithNoErrors; else report.displaySuccessResults = displaySuccessResults;
	if(null == headerDisplayMode) report.displayHeader = utest_ui_common_HeaderDisplayMode.ShowHeaderWithResults; else report.displayHeader = headerDisplayMode;
	return report;
};
var utest_ui_common_ClassResult = function(className,setupName,teardownName) {
	this.fixtures = new haxe_ds_StringMap();
	this.className = className;
	this.setupName = setupName;
	this.hasSetup = setupName != null;
	this.teardownName = teardownName;
	this.hasTeardown = teardownName != null;
	this.methods = 0;
	this.stats = new utest_ui_common_ResultStats();
};
utest_ui_common_ClassResult.__name__ = ["utest","ui","common","ClassResult"];
utest_ui_common_ClassResult.prototype = {
	fixtures: null
	,className: null
	,setupName: null
	,teardownName: null
	,hasSetup: null
	,hasTeardown: null
	,methods: null
	,stats: null
	,add: function(result) {
		if(this.fixtures.exists(result.methodName)) throw "invalid duplicated fixture result";
		this.stats.wire(result.stats);
		this.methods++;
		this.fixtures.set(result.methodName,result);
	}
	,get: function(method) {
		return this.fixtures.get(method);
	}
	,exists: function(method) {
		return this.fixtures.exists(method);
	}
	,methodNames: function(errorsHavePriority) {
		if(errorsHavePriority == null) errorsHavePriority = true;
		var names = [];
		var $it0 = this.fixtures.keys();
		while( $it0.hasNext() ) {
			var name = $it0.next();
			names.push(name);
		}
		if(errorsHavePriority) {
			var me = this;
			names.sort(function(a,b) {
				var $as = me.get(a).stats;
				var bs = me.get(b).stats;
				if($as.hasErrors) if(!bs.hasErrors) return -1; else if($as.errors == bs.errors) return Reflect.compare(a,b); else return Reflect.compare($as.errors,bs.errors); else if(bs.hasErrors) return 1; else if($as.hasFailures) if(!bs.hasFailures) return -1; else if($as.failures == bs.failures) return Reflect.compare(a,b); else return Reflect.compare($as.failures,bs.failures); else if(bs.hasFailures) return 1; else if($as.hasWarnings) if(!bs.hasWarnings) return -1; else if($as.warnings == bs.warnings) return Reflect.compare(a,b); else return Reflect.compare($as.warnings,bs.warnings); else if(bs.hasWarnings) return 1; else return Reflect.compare(a,b);
			});
		} else names.sort(function(a1,b1) {
			return Reflect.compare(a1,b1);
		});
		return names;
	}
	,__class__: utest_ui_common_ClassResult
};
var utest_ui_common_FixtureResult = function(methodName) {
	this.methodName = methodName;
	this.list = new List();
	this.hasTestError = false;
	this.hasSetupError = false;
	this.hasTeardownError = false;
	this.hasTimeoutError = false;
	this.hasAsyncError = false;
	this.stats = new utest_ui_common_ResultStats();
};
utest_ui_common_FixtureResult.__name__ = ["utest","ui","common","FixtureResult"];
utest_ui_common_FixtureResult.prototype = {
	methodName: null
	,hasTestError: null
	,hasSetupError: null
	,hasTeardownError: null
	,hasTimeoutError: null
	,hasAsyncError: null
	,stats: null
	,list: null
	,iterator: function() {
		return this.list.iterator();
	}
	,add: function(assertation) {
		this.list.add(assertation);
		switch(assertation[1]) {
		case 0:
			this.stats.addSuccesses(1);
			break;
		case 1:
			this.stats.addFailures(1);
			break;
		case 2:
			this.stats.addErrors(1);
			break;
		case 3:
			this.stats.addErrors(1);
			this.hasSetupError = true;
			break;
		case 4:
			this.stats.addErrors(1);
			this.hasTeardownError = true;
			break;
		case 5:
			this.stats.addErrors(1);
			this.hasTimeoutError = true;
			break;
		case 6:
			this.stats.addErrors(1);
			this.hasAsyncError = true;
			break;
		case 7:
			this.stats.addWarnings(1);
			break;
		}
	}
	,__class__: utest_ui_common_FixtureResult
};
var utest_ui_common_HeaderDisplayMode = { __ename__ : ["utest","ui","common","HeaderDisplayMode"], __constructs__ : ["AlwaysShowHeader","NeverShowHeader","ShowHeaderWithResults"] };
utest_ui_common_HeaderDisplayMode.AlwaysShowHeader = ["AlwaysShowHeader",0];
utest_ui_common_HeaderDisplayMode.AlwaysShowHeader.__enum__ = utest_ui_common_HeaderDisplayMode;
utest_ui_common_HeaderDisplayMode.NeverShowHeader = ["NeverShowHeader",1];
utest_ui_common_HeaderDisplayMode.NeverShowHeader.__enum__ = utest_ui_common_HeaderDisplayMode;
utest_ui_common_HeaderDisplayMode.ShowHeaderWithResults = ["ShowHeaderWithResults",2];
utest_ui_common_HeaderDisplayMode.ShowHeaderWithResults.__enum__ = utest_ui_common_HeaderDisplayMode;
var utest_ui_common_SuccessResultsDisplayMode = { __ename__ : ["utest","ui","common","SuccessResultsDisplayMode"], __constructs__ : ["AlwaysShowSuccessResults","NeverShowSuccessResults","ShowSuccessResultsWithNoErrors"] };
utest_ui_common_SuccessResultsDisplayMode.AlwaysShowSuccessResults = ["AlwaysShowSuccessResults",0];
utest_ui_common_SuccessResultsDisplayMode.AlwaysShowSuccessResults.__enum__ = utest_ui_common_SuccessResultsDisplayMode;
utest_ui_common_SuccessResultsDisplayMode.NeverShowSuccessResults = ["NeverShowSuccessResults",1];
utest_ui_common_SuccessResultsDisplayMode.NeverShowSuccessResults.__enum__ = utest_ui_common_SuccessResultsDisplayMode;
utest_ui_common_SuccessResultsDisplayMode.ShowSuccessResultsWithNoErrors = ["ShowSuccessResultsWithNoErrors",2];
utest_ui_common_SuccessResultsDisplayMode.ShowSuccessResultsWithNoErrors.__enum__ = utest_ui_common_SuccessResultsDisplayMode;
var utest_ui_common_IReport = function() { };
utest_ui_common_IReport.__name__ = ["utest","ui","common","IReport"];
utest_ui_common_IReport.prototype = {
	displaySuccessResults: null
	,displayHeader: null
	,setHandler: null
	,__class__: utest_ui_common_IReport
};
var utest_ui_common_PackageResult = function(packageName) {
	this.packageName = packageName;
	this.classes = new haxe_ds_StringMap();
	this.packages = new haxe_ds_StringMap();
	this.stats = new utest_ui_common_ResultStats();
};
utest_ui_common_PackageResult.__name__ = ["utest","ui","common","PackageResult"];
utest_ui_common_PackageResult.prototype = {
	packageName: null
	,classes: null
	,packages: null
	,stats: null
	,addResult: function(result,flattenPackage) {
		var pack = this.getOrCreatePackage(result.pack,flattenPackage,this);
		var cls = this.getOrCreateClass(pack,result.cls,result.setup,result.teardown);
		var fix = this.createFixture(result.method,result.assertations);
		cls.add(fix);
	}
	,addClass: function(result) {
		this.classes.set(result.className,result);
		this.stats.wire(result.stats);
	}
	,addPackage: function(result) {
		this.packages.set(result.packageName,result);
		this.stats.wire(result.stats);
	}
	,existsPackage: function(name) {
		return this.packages.exists(name);
	}
	,existsClass: function(name) {
		return this.classes.exists(name);
	}
	,getPackage: function(name) {
		if(this.packageName == null && name == "") return this;
		return this.packages.get(name);
	}
	,getClass: function(name) {
		return this.classes.get(name);
	}
	,classNames: function(errorsHavePriority) {
		if(errorsHavePriority == null) errorsHavePriority = true;
		var names = [];
		var $it0 = this.classes.keys();
		while( $it0.hasNext() ) {
			var name = $it0.next();
			names.push(name);
		}
		if(errorsHavePriority) {
			var me = this;
			names.sort(function(a,b) {
				var $as = me.getClass(a).stats;
				var bs = me.getClass(b).stats;
				if($as.hasErrors) if(!bs.hasErrors) return -1; else if($as.errors == bs.errors) return Reflect.compare(a,b); else return Reflect.compare($as.errors,bs.errors); else if(bs.hasErrors) return 1; else if($as.hasFailures) if(!bs.hasFailures) return -1; else if($as.failures == bs.failures) return Reflect.compare(a,b); else return Reflect.compare($as.failures,bs.failures); else if(bs.hasFailures) return 1; else if($as.hasWarnings) if(!bs.hasWarnings) return -1; else if($as.warnings == bs.warnings) return Reflect.compare(a,b); else return Reflect.compare($as.warnings,bs.warnings); else if(bs.hasWarnings) return 1; else return Reflect.compare(a,b);
			});
		} else names.sort(function(a1,b1) {
			return Reflect.compare(a1,b1);
		});
		return names;
	}
	,packageNames: function(errorsHavePriority) {
		if(errorsHavePriority == null) errorsHavePriority = true;
		var names = [];
		if(this.packageName == null) names.push("");
		var $it0 = this.packages.keys();
		while( $it0.hasNext() ) {
			var name = $it0.next();
			names.push(name);
		}
		if(errorsHavePriority) {
			var me = this;
			names.sort(function(a,b) {
				var $as = me.getPackage(a).stats;
				var bs = me.getPackage(b).stats;
				if($as.hasErrors) if(!bs.hasErrors) return -1; else if($as.errors == bs.errors) return Reflect.compare(a,b); else return Reflect.compare($as.errors,bs.errors); else if(bs.hasErrors) return 1; else if($as.hasFailures) if(!bs.hasFailures) return -1; else if($as.failures == bs.failures) return Reflect.compare(a,b); else return Reflect.compare($as.failures,bs.failures); else if(bs.hasFailures) return 1; else if($as.hasWarnings) if(!bs.hasWarnings) return -1; else if($as.warnings == bs.warnings) return Reflect.compare(a,b); else return Reflect.compare($as.warnings,bs.warnings); else if(bs.hasWarnings) return 1; else return Reflect.compare(a,b);
			});
		} else names.sort(function(a1,b1) {
			return Reflect.compare(a1,b1);
		});
		return names;
	}
	,createFixture: function(method,assertations) {
		var f = new utest_ui_common_FixtureResult(method);
		var $it0 = $iterator(assertations)();
		while( $it0.hasNext() ) {
			var assertation = $it0.next();
			f.add(assertation);
		}
		return f;
	}
	,getOrCreateClass: function(pack,cls,setup,teardown) {
		if(pack.existsClass(cls)) return pack.getClass(cls);
		var c = new utest_ui_common_ClassResult(cls,setup,teardown);
		pack.addClass(c);
		return c;
	}
	,getOrCreatePackage: function(pack,flat,ref) {
		if(pack == null || pack == "") return ref;
		if(flat) {
			if(ref.existsPackage(pack)) return ref.getPackage(pack);
			var p = new utest_ui_common_PackageResult(pack);
			ref.addPackage(p);
			return p;
		} else {
			var parts = pack.split(".");
			var _g = 0;
			while(_g < parts.length) {
				var part = parts[_g];
				++_g;
				ref = this.getOrCreatePackage(part,true,ref);
			}
			return ref;
		}
	}
	,__class__: utest_ui_common_PackageResult
};
var utest_ui_common_ReportTools = function() { };
utest_ui_common_ReportTools.__name__ = ["utest","ui","common","ReportTools"];
utest_ui_common_ReportTools.hasHeader = function(report,stats) {
	var _g = report.displayHeader;
	switch(_g[1]) {
	case 1:
		return false;
	case 2:
		if(!stats.isOk) return true;
		var _g1 = report.displaySuccessResults;
		switch(_g1[1]) {
		case 1:
			return false;
		case 0:case 2:
			return true;
		}
		break;
	case 0:
		return true;
	}
};
utest_ui_common_ReportTools.skipResult = function(report,stats,isOk) {
	if(!stats.isOk) return false;
	var _g = report.displaySuccessResults;
	switch(_g[1]) {
	case 1:
		return true;
	case 0:
		return false;
	case 2:
		return !isOk;
	}
};
utest_ui_common_ReportTools.hasOutput = function(report,stats) {
	if(!stats.isOk) return true;
	return utest_ui_common_ReportTools.hasHeader(report,stats);
};
var utest_ui_common_ResultAggregator = function(runner,flattenPackage) {
	if(flattenPackage == null) flattenPackage = false;
	if(runner == null) throw "runner argument is null";
	this.flattenPackage = flattenPackage;
	this.runner = runner;
	runner.onStart.add($bind(this,this.start));
	runner.onProgress.add($bind(this,this.progress));
	runner.onComplete.add($bind(this,this.complete));
	this.onStart = new utest_Notifier();
	this.onComplete = new utest_Dispatcher();
	this.onProgress = new utest_Dispatcher();
};
utest_ui_common_ResultAggregator.__name__ = ["utest","ui","common","ResultAggregator"];
utest_ui_common_ResultAggregator.prototype = {
	runner: null
	,flattenPackage: null
	,root: null
	,onStart: null
	,onComplete: null
	,onProgress: null
	,start: function(runner) {
		this.root = new utest_ui_common_PackageResult(null);
		this.onStart.dispatch();
	}
	,getOrCreatePackage: function(pack,flat,ref) {
		if(ref == null) ref = this.root;
		if(pack == null || pack == "") return ref;
		if(flat) {
			if(ref.existsPackage(pack)) return ref.getPackage(pack);
			var p = new utest_ui_common_PackageResult(pack);
			ref.addPackage(p);
			return p;
		} else {
			var parts = pack.split(".");
			var _g = 0;
			while(_g < parts.length) {
				var part = parts[_g];
				++_g;
				ref = this.getOrCreatePackage(part,true,ref);
			}
			return ref;
		}
	}
	,getOrCreateClass: function(pack,cls,setup,teardown) {
		if(pack.existsClass(cls)) return pack.getClass(cls);
		var c = new utest_ui_common_ClassResult(cls,setup,teardown);
		pack.addClass(c);
		return c;
	}
	,createFixture: function(result) {
		var f = new utest_ui_common_FixtureResult(result.method);
		var $it0 = result.assertations.iterator();
		while( $it0.hasNext() ) {
			var assertation = $it0.next();
			f.add(assertation);
		}
		return f;
	}
	,progress: function(e) {
		this.root.addResult(e.result,this.flattenPackage);
		this.onProgress.dispatch(e);
	}
	,complete: function(runner) {
		this.onComplete.dispatch(this.root);
	}
	,__class__: utest_ui_common_ResultAggregator
};
var utest_ui_common_ResultStats = function() {
	this.assertations = 0;
	this.successes = 0;
	this.failures = 0;
	this.errors = 0;
	this.warnings = 0;
	this.isOk = true;
	this.hasFailures = false;
	this.hasErrors = false;
	this.hasWarnings = false;
	this.onAddSuccesses = new utest_Dispatcher();
	this.onAddFailures = new utest_Dispatcher();
	this.onAddErrors = new utest_Dispatcher();
	this.onAddWarnings = new utest_Dispatcher();
};
utest_ui_common_ResultStats.__name__ = ["utest","ui","common","ResultStats"];
utest_ui_common_ResultStats.prototype = {
	assertations: null
	,successes: null
	,failures: null
	,errors: null
	,warnings: null
	,onAddSuccesses: null
	,onAddFailures: null
	,onAddErrors: null
	,onAddWarnings: null
	,isOk: null
	,hasFailures: null
	,hasErrors: null
	,hasWarnings: null
	,addSuccesses: function(v) {
		if(v == 0) return;
		this.assertations += v;
		this.successes += v;
		this.onAddSuccesses.dispatch(v);
	}
	,addFailures: function(v) {
		if(v == 0) return;
		this.assertations += v;
		this.failures += v;
		this.hasFailures = this.failures > 0;
		this.isOk = !(this.hasFailures || this.hasErrors || this.hasWarnings);
		this.onAddFailures.dispatch(v);
	}
	,addErrors: function(v) {
		if(v == 0) return;
		this.assertations += v;
		this.errors += v;
		this.hasErrors = this.errors > 0;
		this.isOk = !(this.hasFailures || this.hasErrors || this.hasWarnings);
		this.onAddErrors.dispatch(v);
	}
	,addWarnings: function(v) {
		if(v == 0) return;
		this.assertations += v;
		this.warnings += v;
		this.hasWarnings = this.warnings > 0;
		this.isOk = !(this.hasFailures || this.hasErrors || this.hasWarnings);
		this.onAddWarnings.dispatch(v);
	}
	,sum: function(other) {
		this.addSuccesses(other.successes);
		this.addFailures(other.failures);
		this.addErrors(other.errors);
		this.addWarnings(other.warnings);
	}
	,subtract: function(other) {
		this.addSuccesses(-other.successes);
		this.addFailures(-other.failures);
		this.addErrors(-other.errors);
		this.addWarnings(-other.warnings);
	}
	,wire: function(dependant) {
		dependant.onAddSuccesses.add($bind(this,this.addSuccesses));
		dependant.onAddFailures.add($bind(this,this.addFailures));
		dependant.onAddErrors.add($bind(this,this.addErrors));
		dependant.onAddWarnings.add($bind(this,this.addWarnings));
		this.sum(dependant);
	}
	,unwire: function(dependant) {
		dependant.onAddSuccesses.remove($bind(this,this.addSuccesses));
		dependant.onAddFailures.remove($bind(this,this.addFailures));
		dependant.onAddErrors.remove($bind(this,this.addErrors));
		dependant.onAddWarnings.remove($bind(this,this.addWarnings));
		this.subtract(dependant);
	}
	,__class__: utest_ui_common_ResultStats
};
var utest_ui_text_HtmlReport = function(runner,outputHandler,traceRedirected) {
	if(traceRedirected == null) traceRedirected = true;
	this.aggregator = new utest_ui_common_ResultAggregator(runner,true);
	runner.onStart.add($bind(this,this.start));
	this.aggregator.onComplete.add($bind(this,this.complete));
	if(null == outputHandler) this.setHandler($bind(this,this._handler)); else this.setHandler(outputHandler);
	if(traceRedirected) this.redirectTrace();
	this.displaySuccessResults = utest_ui_common_SuccessResultsDisplayMode.AlwaysShowSuccessResults;
	this.displayHeader = utest_ui_common_HeaderDisplayMode.AlwaysShowHeader;
};
utest_ui_text_HtmlReport.__name__ = ["utest","ui","text","HtmlReport"];
utest_ui_text_HtmlReport.__interfaces__ = [utest_ui_common_IReport];
utest_ui_text_HtmlReport.prototype = {
	traceRedirected: null
	,displaySuccessResults: null
	,displayHeader: null
	,handler: null
	,aggregator: null
	,oldTrace: null
	,_traces: null
	,setHandler: function(handler) {
		this.handler = handler;
	}
	,redirectTrace: function() {
		if(this.traceRedirected) return;
		this._traces = [];
		this.oldTrace = haxe_Log.trace;
		haxe_Log.trace = $bind(this,this._trace);
	}
	,restoreTrace: function() {
		if(!this.traceRedirected) return;
		haxe_Log.trace = this.oldTrace;
	}
	,_traceTime: null
	,_trace: function(v,infos) {
		var time = haxe_Timer.stamp();
		var delta;
		if(this._traceTime == null) delta = 0; else delta = time - this._traceTime;
		this._traces.push({ msg : StringTools.htmlEscape(Std.string(v)), infos : infos, time : time - this.startTime, delta : delta, stack : haxe_CallStack.callStack()});
		this._traceTime = haxe_Timer.stamp();
	}
	,startTime: null
	,start: function(e) {
		this.startTime = haxe_Timer.stamp();
	}
	,cls: function(stats) {
		if(stats.hasErrors) return "error"; else if(stats.hasFailures) return "failure"; else if(stats.hasWarnings) return "warn"; else return "ok";
	}
	,resultNumbers: function(buf,stats) {
		var numbers = [];
		if(stats.assertations == 1) numbers.push("<strong>1</strong> test"); else numbers.push("<strong>" + stats.assertations + "</strong> tests");
		if(stats.successes != stats.assertations) {
			if(stats.successes == 1) numbers.push("<strong>1</strong> pass"); else if(stats.successes > 0) numbers.push("<strong>" + stats.successes + "</strong> passes");
		}
		if(stats.errors == 1) numbers.push("<strong>1</strong> error"); else if(stats.errors > 0) numbers.push("<strong>" + stats.errors + "</strong> errors");
		if(stats.failures == 1) numbers.push("<strong>1</strong> failure"); else if(stats.failures > 0) numbers.push("<strong>" + stats.failures + "</strong> failures");
		if(stats.warnings == 1) numbers.push("<strong>1</strong> warning"); else if(stats.warnings > 0) numbers.push("<strong>" + stats.warnings + "</strong> warnings");
		buf.add(numbers.join(", "));
	}
	,blockNumbers: function(buf,stats) {
		buf.add("<div class=\"" + this.cls(stats) + "bg statnumbers\">");
		this.resultNumbers(buf,stats);
		buf.b += "</div>";
	}
	,formatStack: function(stack,addNL) {
		if(addNL == null) addNL = true;
		var parts = [];
		var nl;
		if(addNL) nl = "\n"; else nl = "";
		var last = null;
		var count = 1;
		var _g = 0;
		var _g1 = haxe_CallStack.toString(stack).split("\n");
		while(_g < _g1.length) {
			var part = _g1[_g];
			++_g;
			if(StringTools.trim(part) == "") continue;
			if(-1 < part.indexOf("Called from utest.")) continue;
			if(part == last) parts[parts.length - 1] = part + " (#" + ++count + ")"; else {
				count = 1;
				parts.push(last = part);
			}
		}
		var s = "<ul><li>" + parts.join("</li>" + nl + "<li>") + "</li></ul>" + nl;
		return "<div>" + s + "</div>" + nl;
	}
	,addFixture: function(buf,result,name,isOk) {
		if(utest_ui_common_ReportTools.skipResult(this,result.stats,isOk)) return;
		buf.b += "<li class=\"fixture\"><div class=\"li\">";
		buf.add("<span class=\"" + this.cls(result.stats) + "bg fixtureresult\">");
		if(result.stats.isOk) buf.b += "OK "; else if(result.stats.hasErrors) buf.b += "ERROR "; else if(result.stats.hasFailures) buf.b += "FAILURE "; else if(result.stats.hasWarnings) buf.b += "WARNING ";
		buf.b += "</span>";
		buf.b += "<div class=\"fixturedetails\">";
		buf.b += Std.string("<strong>" + name + "</strong>");
		buf.b += ": ";
		this.resultNumbers(buf,result.stats);
		var messages = [];
		var $it0 = result.iterator();
		while( $it0.hasNext() ) {
			var assertation = $it0.next();
			switch(assertation[1]) {
			case 0:
				break;
			case 1:
				var pos = assertation[3];
				var msg = assertation[2];
				messages.push("<strong>line " + pos.lineNumber + "</strong>: <em>" + StringTools.htmlEscape(msg) + "</em>");
				break;
			case 2:
				var s = assertation[3];
				var e = assertation[2];
				messages.push("<strong>error</strong>: <em>" + this.getErrorDescription(e) + "</em>\n<br/><strong>stack</strong>:" + this.getErrorStack(s,e));
				break;
			case 3:
				var s1 = assertation[3];
				var e1 = assertation[2];
				messages.push("<strong>setup error</strong>: " + this.getErrorDescription(e1) + "\n<br/><strong>stack</strong>:" + this.getErrorStack(s1,e1));
				break;
			case 4:
				var s2 = assertation[3];
				var e2 = assertation[2];
				messages.push("<strong>tear-down error</strong>: " + this.getErrorDescription(e2) + "\n<br/><strong>stack</strong>:" + this.getErrorStack(s2,e2));
				break;
			case 5:
				var missedAsyncs = assertation[2];
				messages.push("<strong>missed async call(s)</strong>: " + missedAsyncs);
				break;
			case 6:
				var s3 = assertation[3];
				var e3 = assertation[2];
				messages.push("<strong>async error</strong>: " + this.getErrorDescription(e3) + "\n<br/><strong>stack</strong>:" + this.getErrorStack(s3,e3));
				break;
			case 7:
				var msg1 = assertation[2];
				messages.push(StringTools.htmlEscape(msg1));
				break;
			}
		}
		if(messages.length > 0) {
			buf.b += "<div class=\"testoutput\">";
			buf.add(messages.join("<br/>"));
			buf.b += "</div>\n";
		}
		buf.b += "</div>\n";
		buf.b += "</div></li>\n";
	}
	,getErrorDescription: function(e) {
		return Std.string(e);
	}
	,getErrorStack: function(s,e) {
		return this.formatStack(s);
	}
	,addClass: function(buf,result,name,isOk) {
		if(utest_ui_common_ReportTools.skipResult(this,result.stats,isOk)) return;
		buf.b += "<li>";
		buf.b += Std.string("<h2 class=\"classname\">" + name + "</h2>");
		this.blockNumbers(buf,result.stats);
		buf.b += "<ul>\n";
		var _g = 0;
		var _g1 = result.methodNames();
		while(_g < _g1.length) {
			var mname = _g1[_g];
			++_g;
			this.addFixture(buf,result.get(mname),mname,isOk);
		}
		buf.b += "</ul>\n";
		buf.b += "</li>\n";
	}
	,addPackages: function(buf,result,isOk) {
		if(utest_ui_common_ReportTools.skipResult(this,result.stats,isOk)) return;
		buf.b += "<ul id=\"utest-results-packages\">\n";
		var _g = 0;
		var _g1 = result.packageNames(false);
		while(_g < _g1.length) {
			var name = _g1[_g];
			++_g;
			this.addPackage(buf,result.getPackage(name),name,isOk);
		}
		buf.b += "</ul>\n";
	}
	,addPackage: function(buf,result,name,isOk) {
		if(utest_ui_common_ReportTools.skipResult(this,result.stats,isOk)) return;
		if(name == "" && result.classNames().length == 0) return;
		buf.b += "<li>";
		buf.b += Std.string("<h2>" + name + "</h2>");
		this.blockNumbers(buf,result.stats);
		buf.b += "<ul>\n";
		var _g = 0;
		var _g1 = result.classNames();
		while(_g < _g1.length) {
			var cname = _g1[_g];
			++_g;
			this.addClass(buf,result.getClass(cname),cname,isOk);
		}
		buf.b += "</ul>\n";
		buf.b += "</li>\n";
	}
	,getHeader: function() {
		var buf = new StringBuf();
		if(!utest_ui_common_ReportTools.hasHeader(this,this.result.stats)) return "";
		var end = haxe_Timer.stamp();
		var time = ((end - this.startTime) * 1000 | 0) / 1000;
		var msg = "TEST OK";
		if(this.result.stats.hasErrors) msg = "TEST ERRORS"; else if(this.result.stats.hasFailures) msg = "TEST FAILED"; else if(this.result.stats.hasWarnings) msg = "WARNING REPORTED";
		buf.add("<h1 class=\"" + this.cls(this.result.stats) + "bg header\">" + msg + "</h1>\n");
		buf.b += "<div class=\"headerinfo\">";
		this.resultNumbers(buf,this.result.stats);
		buf.b += Std.string(" performed on <strong>" + utest_ui_text_HtmlReport.platform + "</strong>, executed in <strong> " + time + " sec. </strong></div >\n ");
		return buf.b;
	}
	,getTrace: function() {
		var buf = new StringBuf();
		if(this._traces == null || this._traces.length == 0) return "";
		buf.b += "<div class=\"trace\"><h2>traces</h2><ol>";
		var _g = 0;
		var _g1 = this._traces;
		while(_g < _g1.length) {
			var t = _g1[_g];
			++_g;
			buf.b += "<li><div class=\"li\">";
			var stack = StringTools.replace(this.formatStack(t.stack,false),"'","\\'");
			var method = "<span class=\"tracepackage\">" + t.infos.className + "</span><br/>" + t.infos.methodName + "(" + t.infos.lineNumber + ")";
			buf.b += Std.string("<span class=\"tracepos\" onmouseover=\"utestTooltip(this.parentNode, '" + stack + "')\" onmouseout=\"utestRemoveTooltip()\">");
			if(method == null) buf.b += "null"; else buf.b += "" + method;
			buf.b += "</span><span class=\"tracetime\">";
			buf.add("@ " + this.formatTime(t.time));
			if(Math.round(t.delta * 1000) > 0) buf.add(", ~" + this.formatTime(t.delta));
			buf.b += "</span><span class=\"tracemsg\">";
			buf.add(StringTools.replace(StringTools.trim(t.msg),"\n","<br/>\n"));
			buf.b += "</span><div class=\"clr\"></div></div></li>";
		}
		buf.b += "</ol></div>";
		return buf.b;
	}
	,getResults: function() {
		var buf = new StringBuf();
		this.addPackages(buf,this.result,this.result.stats.isOk);
		return buf.b;
	}
	,getAll: function() {
		if(!utest_ui_common_ReportTools.hasOutput(this,this.result.stats)) return ""; else return this.getHeader() + this.getTrace() + this.getResults();
	}
	,getHtml: function(title) {
		if(null == title) title = "utest: " + utest_ui_text_HtmlReport.platform;
		var s = this.getAll();
		if("" == s) return ""; else return this.wrapHtml(title,s);
	}
	,result: null
	,complete: function(result) {
		this.result = result;
		this.handler(this);
		this.restoreTrace();
	}
	,formatTime: function(t) {
		return Math.round(t * 1000) + " ms";
	}
	,cssStyle: function() {
		return "body, dd, dt {\n\tfont-family: Verdana, Arial, Sans-serif;\n\tfont-size: 12px;\n}\ndl {\n\twidth: 180px;\n}\ndd, dt {\n\tmargin : 0;\n\tpadding : 2px 5px;\n\tborder-top: 1px solid #f0f0f0;\n\tborder-left: 1px solid #f0f0f0;\n\tborder-right: 1px solid #CCCCCC;\n\tborder-bottom: 1px solid #CCCCCC;\n}\ndd.value {\n\ttext-align: center;\n\tbackground-color: #eeeeee;\n}\ndt {\n\ttext-align: left;\n\tbackground-color: #e6e6e6;\n\tfloat: left;\n\twidth: 100px;\n}\n\nh1, h2, h3, h4, h5, h6 {\n\tmargin: 0;\n\tpadding: 0;\n}\n\nh1 {\n\ttext-align: center;\n\tfont-weight: bold;\n\tpadding: 5px 0 4px 0;\n\tfont-family: Arial, Sans-serif;\n\tfont-size: 18px;\n\tborder-top: 1px solid #f0f0f0;\n\tborder-left: 1px solid #f0f0f0;\n\tborder-right: 1px solid #CCCCCC;\n\tborder-bottom: 1px solid #CCCCCC;\n\tmargin: 0 2px 0px 2px;\n}\n\nh2 {\n\tfont-weight: bold;\n\tpadding: 2px 0 2px 8px;\n\tfont-family: Arial, Sans-serif;\n\tfont-size: 13px;\n\tborder-top: 1px solid #f0f0f0;\n\tborder-left: 1px solid #f0f0f0;\n\tborder-right: 1px solid #CCCCCC;\n\tborder-bottom: 1px solid #CCCCCC;\n\tmargin: 0 0 0px 0;\n\tbackground-color: #FFFFFF;\n\tcolor: #777777;\n}\n\nh2.classname {\n\tcolor: #000000;\n}\n\n.okbg {\n\tbackground-color: #66FF55;\n}\n.errorbg {\n\tbackground-color: #CC1100;\n}\n.failurebg {\n\tbackground-color: #EE3322;\n}\n.warnbg {\n\tbackground-color: #FFCC99;\n}\n.headerinfo {\n\ttext-align: right;\n\tfont-size: 11px;\n\tfont - color: 0xCCCCCC;\n\tmargin: 0 2px 5px 2px;\n\tborder-left: 1px solid #f0f0f0;\n\tborder-right: 1px solid #CCCCCC;\n\tborder-bottom: 1px solid #CCCCCC;\n\tpadding: 2px;\n}\n\nli {\n\tpadding: 4px;\n\tmargin: 2px;\n\tborder-top: 1px solid #f0f0f0;\n\tborder-left: 1px solid #f0f0f0;\n\tborder-right: 1px solid #CCCCCC;\n\tborder-bottom: 1px solid #CCCCCC;\n\tbackground-color: #e6e6e6;\n}\n\nli.fixture {\n\tbackground-color: #f6f6f6;\n\tpadding-bottom: 6px;\n}\n\ndiv.fixturedetails {\n\tpadding-left: 108px;\n}\n\nul {\n\tpadding: 0;\n\tmargin: 6px 0 0 0;\n\tlist-style-type: none;\n}\n\nol {\n\tpadding: 0 0 0 28px;\n\tmargin: 0px 0 0 0;\n}\n\n.statnumbers {\n\tpadding: 2px 8px;\n}\n\n.fixtureresult {\n\twidth: 100px;\n\ttext-align: center;\n\tdisplay: block;\n\tfloat: left;\n\tfont-weight: bold;\n\tpadding: 1px;\n\tmargin: 0 0 0 0;\n}\n\n.testoutput {\n\tborder: 1px dashed #CCCCCC;\n\tmargin: 4px 0 0 0;\n\tpadding: 4px 8px;\n\tbackground-color: #eeeeee;\n}\n\nspan.tracepos, span.traceposempty {\n\tdisplay: block;\n\tfloat: left;\n\tfont-weight: bold;\n\tfont-size: 9px;\n\twidth: 170px;\n\tmargin: 2px 0 0 2px;\n}\n\nspan.tracepos:hover {\n\tcursor : pointer;\n\tbackground-color: #ffff99;\n}\n\nspan.tracemsg {\n\tdisplay: block;\n\tmargin-left: 180px;\n\tbackground-color: #eeeeee;\n\tpadding: 7px;\n}\n\nspan.tracetime {\n\tdisplay: block;\n\tfloat: right;\n\tmargin: 2px;\n\tfont-size: 9px;\n\tcolor: #777777;\n}\n\n\ndiv.trace ol {\n\tpadding: 0 0 0 40px;\n\tcolor: #777777;\n}\n\ndiv.trace li {\n\tpadding: 0;\n}\n\ndiv.trace li div.li {\n\tcolor: #000000;\n}\n\ndiv.trace h2 {\n\tmargin: 0 2px 0px 2px;\n\tpadding-left: 4px;\n}\n\n.tracepackage {\n\tcolor: #777777;\n\tfont-weight: normal;\n}\n\n.clr {\n\tclear: both;\n}\n\n#utesttip {\n\tmargin-top: -3px;\n\tmargin-left: 170px;\n\tfont-size: 9px;\n}\n\n#utesttip li {\n\tmargin: 0;\n\tbackground-color: #ffff99;\n\tpadding: 2px 4px;\n\tborder: 0;\n\tborder-bottom: 1px dashed #ffff33;\n}";
	}
	,jsScript: function() {
		return "function utestTooltip(ref, text) {\n\tvar el = document.getElementById(\"utesttip\");\n\tif(!el) {\n\t\tvar el = document.createElement(\"div\")\n\t\tel.id = \"utesttip\";\n\t\tel.style.position = \"absolute\";\n\t\tdocument.body.appendChild(el)\n\t}\n\tvar p = utestFindPos(ref);\n\tel.style.left = (4 + p[0]) + \"px\";\n\tel.style.top = (p[1] - 1) + \"px\";\n\tel.innerHTML =  text;\n}\n\nfunction utestFindPos(el) {\n\tvar left = 0;\n\tvar top = 0;\n\tdo {\n\t\tleft += el.offsetLeft;\n\t\ttop += el.offsetTop;\n\t} while(el = el.offsetParent)\n\treturn [left, top];\n}\n\nfunction utestRemoveTooltip() {\n\tvar el = document.getElementById(\"utesttip\")\n\tif(el)\n\t\tdocument.body.removeChild(el)\n}";
	}
	,wrapHtml: function(title,s) {
		return "<head>\n<meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\" />\n<title>" + title + "</title>\n\t\t\t<style type=\"text/css\">" + this.cssStyle() + "</style>\n\t\t\t<script type=\"text/javascript\">\n" + this.jsScript() + "\n</script>\n</head>\n\t\t\t<body>\n" + s + "\n</body>\n</html>";
	}
	,_handler: function(report) {
		__js__(process.stdout.write)(report.getHtml());
	}
	,__class__: utest_ui_text_HtmlReport
};
var utest_ui_text_PlainTextReport = function(runner,outputHandler) {
	this.aggregator = new utest_ui_common_ResultAggregator(runner,true);
	runner.onStart.add($bind(this,this.start));
	this.aggregator.onComplete.add($bind(this,this.complete));
	if(null != outputHandler) this.setHandler(outputHandler);
	this.displaySuccessResults = utest_ui_common_SuccessResultsDisplayMode.AlwaysShowSuccessResults;
	this.displayHeader = utest_ui_common_HeaderDisplayMode.AlwaysShowHeader;
};
utest_ui_text_PlainTextReport.__name__ = ["utest","ui","text","PlainTextReport"];
utest_ui_text_PlainTextReport.__interfaces__ = [utest_ui_common_IReport];
utest_ui_text_PlainTextReport.prototype = {
	displaySuccessResults: null
	,displayHeader: null
	,handler: null
	,aggregator: null
	,newline: null
	,indent: null
	,setHandler: function(handler) {
		this.handler = handler;
	}
	,startTime: null
	,start: function(e) {
		this.startTime = haxe_Timer.stamp();
	}
	,indents: function(c) {
		var s = "";
		var _g = 0;
		while(_g < c) {
			var _ = _g++;
			s += this.indent;
		}
		return s;
	}
	,dumpStack: function(stack) {
		if(stack.length == 0) return "";
		var parts = haxe_CallStack.toString(stack).split("\n");
		var r = [];
		var _g = 0;
		while(_g < parts.length) {
			var part = parts[_g];
			++_g;
			if(part.indexOf(" utest.") >= 0) continue;
			r.push(part);
		}
		return r.join(this.newline);
	}
	,addHeader: function(buf,result) {
		if(!utest_ui_common_ReportTools.hasHeader(this,result.stats)) return;
		var end = haxe_Timer.stamp();
		var time = ((end - this.startTime) * 1000 | 0) / 1000;
		buf.b += Std.string("results: " + (result.stats.isOk?"ALL TESTS OK":"SOME TESTS FAILURES") + this.newline + this.newline);
		buf.b += Std.string("assertations: " + result.stats.assertations + this.newline);
		buf.b += Std.string("successes: " + result.stats.successes + this.newline);
		buf.b += Std.string("errors: " + result.stats.errors + this.newline);
		buf.b += Std.string("failures: " + result.stats.failures + this.newline);
		buf.b += Std.string("warnings: " + result.stats.warnings + this.newline);
		buf.b += Std.string("execution time: " + time + this.newline);
		buf.b += Std.string(this.newline);
	}
	,result: null
	,getResults: function() {
		var buf = new StringBuf();
		this.addHeader(buf,this.result);
		var _g = 0;
		var _g1 = this.result.packageNames();
		while(_g < _g1.length) {
			var pname = _g1[_g];
			++_g;
			var pack = this.result.getPackage(pname);
			if(utest_ui_common_ReportTools.skipResult(this,pack.stats,this.result.stats.isOk)) continue;
			var _g2 = 0;
			var _g3 = pack.classNames();
			while(_g2 < _g3.length) {
				var cname = _g3[_g2];
				++_g2;
				var cls = pack.getClass(cname);
				if(utest_ui_common_ReportTools.skipResult(this,cls.stats,this.result.stats.isOk)) continue;
				buf.b += Std.string((pname == ""?"":pname + ".") + cname + this.newline);
				var _g4 = 0;
				var _g5 = cls.methodNames();
				while(_g4 < _g5.length) {
					var mname = _g5[_g4];
					++_g4;
					var fix = cls.get(mname);
					if(utest_ui_common_ReportTools.skipResult(this,fix.stats,this.result.stats.isOk)) continue;
					buf.add(this.indents(1) + mname + ": ");
					if(fix.stats.isOk) buf.b += "OK "; else if(fix.stats.hasErrors) buf.b += "ERROR "; else if(fix.stats.hasFailures) buf.b += "FAILURE "; else if(fix.stats.hasWarnings) buf.b += "WARNING ";
					var messages = "";
					var $it0 = fix.iterator();
					while( $it0.hasNext() ) {
						var assertation = $it0.next();
						switch(assertation[1]) {
						case 0:
							buf.b += ".";
							break;
						case 1:
							var pos = assertation[3];
							var msg = assertation[2];
							buf.b += "F";
							messages += this.indents(2) + "line: " + pos.lineNumber + ", " + msg + this.newline;
							break;
						case 2:
							var s = assertation[3];
							var e = assertation[2];
							buf.b += "E";
							messages += this.indents(2) + Std.string(e) + this.dumpStack(s) + this.newline;
							break;
						case 3:
							var s1 = assertation[3];
							var e1 = assertation[2];
							buf.b += "S";
							messages += this.indents(2) + Std.string(e1) + this.dumpStack(s1) + this.newline;
							break;
						case 4:
							var s2 = assertation[3];
							var e2 = assertation[2];
							buf.b += "T";
							messages += this.indents(2) + Std.string(e2) + this.dumpStack(s2) + this.newline;
							break;
						case 5:
							var s3 = assertation[3];
							var missedAsyncs = assertation[2];
							buf.b += "O";
							messages += this.indents(2) + "missed async calls: " + missedAsyncs + this.dumpStack(s3) + this.newline;
							break;
						case 6:
							var s4 = assertation[3];
							var e3 = assertation[2];
							buf.b += "A";
							messages += this.indents(2) + Std.string(e3) + this.dumpStack(s4) + this.newline;
							break;
						case 7:
							var msg1 = assertation[2];
							buf.b += "W";
							messages += this.indents(2) + msg1 + this.newline;
							break;
						}
					}
					buf.b += Std.string(this.newline);
					if(messages == null) buf.b += "null"; else buf.b += "" + messages;
				}
			}
		}
		return buf.b;
	}
	,complete: function(result) {
		this.result = result;
		this.handler(this);
	}
	,__class__: utest_ui_text_PlainTextReport
};
var utest_ui_text_PrintReport = function(runner) {
	utest_ui_text_PlainTextReport.call(this,runner,$bind(this,this._handler));
	this.newline = "\n";
	this.indent = "  ";
};
utest_ui_text_PrintReport.__name__ = ["utest","ui","text","PrintReport"];
utest_ui_text_PrintReport.__super__ = utest_ui_text_PlainTextReport;
utest_ui_text_PrintReport.prototype = $extend(utest_ui_text_PlainTextReport.prototype,{
	useTrace: null
	,_handler: function(report) {
		this._trace(report.getResults());
	}
	,_trace: function(s) {
		s = StringTools.replace(s,"  ",this.indent);
		s = StringTools.replace(s,"\n",this.newline);
		haxe_Log.trace(s,{ fileName : "PrintReport.hx", lineNumber : 65, className : "utest.ui.text.PrintReport", methodName : "_trace"});
	}
	,__class__: utest_ui_text_PrintReport
});
function $iterator(o) { if( o instanceof Array ) return function() { return HxOverrides.iter(o); }; return typeof(o.iterator) == 'function' ? $bind(o,o.iterator) : o.iterator; }
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
if(Array.prototype.indexOf) HxOverrides.indexOf = function(a,o,i) {
	return Array.prototype.indexOf.call(a,o,i);
};
String.prototype.__class__ = String;
String.__name__ = ["String"];
Array.__name__ = ["Array"];
Date.prototype.__class__ = Date;
Date.__name__ = ["Date"];
var Int = { __name__ : ["Int"]};
var Dynamic = { __name__ : ["Dynamic"]};
var Float = Number;
Float.__name__ = ["Float"];
var Bool = Boolean;
Bool.__ename__ = ["Bool"];
var Class = { __name__ : ["Class"]};
var Enum = { };
if(Array.prototype.map == null) Array.prototype.map = function(f) {
	var a = [];
	var _g1 = 0;
	var _g = this.length;
	while(_g1 < _g) {
		var i = _g1++;
		a[i] = f(this[i]);
	}
	return a;
};
thx_geom_Const.EPSILON = 1e-5;
thx_geom__$Matrix4x4_Matrix4x4_$Impl_$.unity = [1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1];
thx_geom_Plane.COPLANAR = 0;
thx_geom_Plane.FRONT = 1;
thx_geom_Plane.BACK = 2;
thx_geom_Plane.SPANNING = 3;
thx_geom__$Point3D_Point3D_$Impl_$.zero = [0,0,0];
thx_geom_OrthoNormalBasis.z0Plane = new thx_geom_OrthoNormalBasis(new thx_geom_Plane([0,0,1],0),[1,0,0]);
thx_geom__$Point_Point_$Impl_$.zero = [0,0];
thx_math_Number.TOLERANCE = 10e-5;
thx_math_Number.EPSILON = 10e-10;
thx_math_Number.abscissas = [[0.5773502691896257645091488],[0,0.7745966692414833770358531],[0.3399810435848562648026658,0.8611363115940525752239465],[0,0.5384693101056830910363144,0.9061798459386639927976269],[0.2386191860831969086305017,0.6612093864662645136613996,0.9324695142031520278123016],[0,0.4058451513773971669066064,0.7415311855993944398638648,0.9491079123427585245261897],[0.1834346424956498049394761,0.5255324099163289858177390,0.7966664774136267395915539,0.9602898564975362316835609],[0,0.3242534234038089290385380,0.6133714327005903973087020,0.8360311073266357942994298,0.9681602395076260898355762],[0.1488743389816312108848260,0.4333953941292471907992659,0.6794095682990244062343274,0.8650633666889845107320967,0.9739065285171717200779640],[0,0.2695431559523449723315320,0.5190961292068118159257257,0.7301520055740493240934163,0.8870625997680952990751578,0.9782286581460569928039380],[0.1252334085114689154724414,0.3678314989981801937526915,0.5873179542866174472967024,0.7699026741943046870368938,0.9041172563704748566784659,0.9815606342467192506905491],[0,0.2304583159551347940655281,0.4484927510364468528779129,0.6423493394403402206439846,0.8015780907333099127942065,0.9175983992229779652065478,0.9841830547185881494728294],[0.1080549487073436620662447,0.3191123689278897604356718,0.5152486363581540919652907,0.6872929048116854701480198,0.8272013150697649931897947,0.9284348836635735173363911,0.9862838086968123388415973],[0,0.2011940939974345223006283,0.3941513470775633698972074,0.5709721726085388475372267,0.7244177313601700474161861,0.8482065834104272162006483,0.9372733924007059043077589,0.9879925180204854284895657],[0.0950125098376374401853193,0.2816035507792589132304605,0.4580167776572273863424194,0.6178762444026437484466718,0.7554044083550030338951012,0.8656312023878317438804679,0.9445750230732325760779884,0.9894009349916499325961542]];
thx_math_Number.weights = [[1.0],[0.8888888888888888888888889,0.5555555555555555555555556],[0.6521451548625461426269361,0.3478548451374538573730639],[0.5688888888888888888888889,0.4786286704993664680412915,0.2369268850561890875142640],[0.4679139345726910473898703,0.3607615730481386075698335,0.1713244923791703450402961],[0.4179591836734693877551020,0.3818300505051189449503698,0.2797053914892766679014678,0.1294849661688696932706114],[0.3626837833783619829651504,0.3137066458778872873379622,0.2223810344533744705443560,0.1012285362903762591525314],[0.3302393550012597631645251,0.3123470770400028400686304,0.2606106964029354623187429,0.1806481606948574040584720,0.0812743883615744119718922],[0.2955242247147528701738930,0.2692667193099963550912269,0.2190863625159820439955349,0.1494513491505805931457763,0.0666713443086881375935688],[0.2729250867779006307144835,0.2628045445102466621806889,0.2331937645919904799185237,0.1862902109277342514260976,0.1255803694649046246346943,0.0556685671161736664827537],[0.2491470458134027850005624,0.2334925365383548087608499,0.2031674267230659217490645,0.1600783285433462263346525,0.1069393259953184309602547,0.0471753363865118271946160],[0.2325515532308739101945895,0.2262831802628972384120902,0.2078160475368885023125232,0.1781459807619457382800467,0.1388735102197872384636018,0.0921214998377284479144218,0.0404840047653158795200216],[0.2152638534631577901958764,0.2051984637212956039659241,0.1855383974779378137417166,0.1572031671581935345696019,0.1215185706879031846894148,0.0801580871597602098056333,0.0351194603317518630318329],[0.2025782419255612728806202,0.1984314853271115764561183,0.1861610000155622110268006,0.1662692058169939335532009,0.1395706779261543144478048,0.1071592204671719350118695,0.0703660474881081247092674,0.0307532419961172683546284],[0.1894506104550684962853967,0.1826034150449235888667637,0.1691565193950025381893121,0.1495959888165767320815017,0.1246289712555338720524763,0.0951585116824927848099251,0.0622535239386478928628438,0.0271524594117540948517806]];
thx_unit_angle_Const.TO_DEGREE = 180 / Math.PI;
utest_TestHandler.POLLING_TIME = 10;
utest_ui_text_HtmlReport.platform = "javascript";
TestAll.main();
})();
