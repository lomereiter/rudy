/*
 * This module simply publicly imports all of the other components of the Rudy
 * package, making them all available from a single point.
 */
module rudy.rudy;

public {
    //import pyd.class_wrap;
    import rudy.lib_abstract;
    import rudy.def;
    import rudy.exception;
    //import rudy.func_wrap;
    import rudy.make_object;
    import rudy.rudyobject;
    //import pyd.struct_wrap;

}

/*
 * Currently, runtime_initialize must be called explicitly,
 * for instance, from Init_* function
 */
import core.runtime : Runtime;

extern (C) void runtime_initialize() {
    Runtime.initialize();
}

extern (C) void runtime_terminate() {
    Runtime.terminate();
}

/* for _deh_beg and such */
void main() {}
