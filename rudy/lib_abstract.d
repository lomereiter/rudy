module rudy.lib_abstract;

string objToStr(Object o) {
    return o.toString();
}

public import meta.Nameof : symbolnameof, prettytypeof, prettynameof;

public import std.traits : ParameterTypeTuple, ReturnType;
public import std.bind : minArgs = minNumArgs;
