/* This file was generated by upbc (the upb compiler) from the input
 * file:
 *
 *     google/api/annotations.proto
 *
 * Do not edit -- your changes will be discarded when the file is
 * regenerated. */

#include <stddef.h>
#include "upb/msg_internal.h"
#include "google/api/annotations.upb.h"
#include "google/api/http.upb.h"
#include "google/protobuf/descriptor.upb.h"

#include "upb/port_def.inc"

extern const upb_msglayout google_api_HttpRule_msginit;
extern const upb_msglayout google_protobuf_MethodOptions_msginit;
const upb_msglayout_ext google_api_http_ext = {
  {72295728, 0, 0, 0, 11, _UPB_MODE_SCALAR | _UPB_MODE_IS_EXTENSION | (_UPB_REP_PTR << _UPB_REP_SHIFT)},
  &google_protobuf_MethodOptions_msginit,
  {.submsg = &google_api_HttpRule_msginit},

};

static const upb_msglayout_ext *extensions_layout[1] = {
  &google_api_http_ext,
};

const upb_msglayout_file google_api_annotations_proto_upb_file_layout = {
  NULL,
  extensions_layout,
  0,
  1,
};

#include "upb/port_undef.inc"

