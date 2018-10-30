#include "kratos.h"

VALUE rb_mKratos;

void
Init_kratos(void)
{
  rb_mKratos = rb_define_module("Kratos");
}
