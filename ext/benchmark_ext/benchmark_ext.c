#include <ruby.h>

VALUE bmm;

long bm_timestamp()
{
  struct timeval tv;
  gettimeofday(&tv, NULL);
  return tv.tv_sec * 1000000 + tv.tv_usec;
}

double bm_tms_value(VALUE tms, const char *name)
{
  return NUM2DBL(rb_funcall(tms, rb_intern(name), 0));
}

/* call-seq:
 timestamp -> Float

 Returns the current UNIX timestamp, as a Float.
*/
VALUE bmm_timestamp(VALUE obj) {
  return rb_float_new((double) bm_timestamp() / 1000000);
}

/* call-seq:
 realtime {block} -> Float

 Returns the elapsed real time used to execute the given block.
*/
VALUE bmm_realtime(VALUE obj)
{
  long t1, t2;

  if (!rb_block_given_p())
  {
    rb_raise(rb_eArgError, "A block must be provided.");
  }

  t1 = bm_timestamp();
  rb_yield(obj);
  t2 = bm_timestamp();
  return rb_float_new((double) (t2 - t1) / 1000000);
}

void Init_benchmark_ext() {
  rb_require("benchmark");
  bmm = rb_define_module("Benchmark");
  rb_define_module_function(bmm, "timestamp", bmm_timestamp, 0);
  rb_define_module_function(bmm, "realtime", bmm_realtime, 0);
}
