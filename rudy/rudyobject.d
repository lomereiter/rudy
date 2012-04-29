module rudy.rudyobject;

//the basics: bindings
import bcd.ruby;

import rudy.exception;



/* Wrapper class for Ruby/C API VALUE universal reference
 *
 * TODO: making it actually working and useful
 * TODO: exceptions
 * TODO: full implementation of converters etc.
 */
class RudyObject {
  protected:
    VALUE rubyval;
  public:
  /*
   * Wrap around a passed Ruby VALUE
   * Params:
   *      v = The VALUE to wrap (and reference).
   *      borrowed = Whether o is a _borrowed reference. This one comes 
   *      straight from PyD and will be left for future reference hash
   *      (that'll be there to satisfy the GC)
   */
    this(VALUE v, bool borrowed=false) 
    {
      if (v == 0) handle_exception();
      // RudyObject will own its references
      // if (borrowed) Py_INCREF(o);
      rubyval = v;
    }

    /// The default constructor constructs an instance of the NilClass.
    this() { this(rb_cNilClass, true); }

    /// Destructor. Left for later
    ~this() {
        //Py_DECREF(m_ptr);
    }
    
    VALUE ptr() { return rubyval; }
    
    /* D operator overloading */
    /* FIXME: I don't get it how to overload opEquals :-( */
    bool opEquals(const RudyObject other) @safe const pure nothrow {
        return opEquals(other);
    }

    bool opEquals(ref const RudyObject other) @safe const pure nothrow {
        uint res = rb_equal(rubyval, other.rubyval);
        //handle_exception();
        return res == Qtrue;
    }

    
    /* conversions */
    RudyObject to_s()
    {
      VALUE stringed = rb_any_to_s(rubyval);
      return new RudyObject(stringed);
    }
    
    long to_i()
    {
      int id_to_i = rb_intern("to_i");
      int result = rb_funcall(rubyval, id_to_i, 0);
      return rb_num2long(result); 
    }
    
    double to_f()
    {
      return RFLOAT(rubyval).value;
    }
}
