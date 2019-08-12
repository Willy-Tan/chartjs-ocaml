open Js_of_ocaml

module Indexable = struct
  type 'a t

  let of_single (x : 'a) : 'a t Js.t = Obj.magic x

  let of_js_array (x : 'a Js.js_array Js.t) : 'a t Js.t =
    Js.Unsafe.coerce x

  let of_array (x : 'a array) : 'a t Js.t =
    of_js_array @@ Js.array x

  let of_list (x : 'a list) : 'a t Js.t =
    of_array @@ Array.of_list x

  let cast_single (t : 'a t Js.t) : 'a Js.opt =
    if Js.instanceof t Js.array_empty
    then Js.null
    else Js.some (Obj.magic t)

  let cast_js_array (t : 'a t Js.t) : 'a Js.js_array Js.t Js.opt =
    if Js.instanceof t Js.array_empty
    then Js.some (Js.Unsafe.coerce t)
    else Js.null
end

module Scriptable = struct
  type ('a, 'b) t

  let of_fun (x : 'a -> 'b) : ('a, 'b) t Js.t =
    Obj.magic @@ Js.wrap_callback x
end

module Scriptable_indexable = struct
  type ('a, 'b) t

  let of_single (x : 'b) : ('a, 'b) t Js.t =
    Obj.magic x

  let of_js_array (x : 'b Js.js_array Js.t) : ('a, 'b) t Js.t =
    Js.Unsafe.coerce x

  let of_array (x : 'b array) : ('a, 'b) t Js.t =
    of_js_array @@ Js.array x

  let of_list (x : 'b list) : ('a, 'b) t Js.t =
    of_array @@ Array.of_list x

  let of_fun (x : 'a -> 'b) : ('a, 'b) t Js.t =
    Obj.magic @@ Js.wrap_callback x

  let cast_single (t : ('a, 'b) t Js.t) : 'b Js.opt =
    if Js.instanceof t Js.array_empty
    then Js.null
    else Js.some (Obj.magic t)

  let cast_js_array (t : ('a, 'b) t Js.t) : 'b Js.js_array Js.t Js.opt =
    if Js.instanceof t Js.array_empty
    then Js.some (Js.Unsafe.coerce t)
    else Js.null

  let cast_fun (t : ('a, 'b) t Js.t) : ('c, 'a -> 'b) Js.meth_callback Js.opt =
    if (Js.typeof t)##toLowerCase == Js.string "function"
    then Js.some @@ Obj.magic t
    else Js.null
end

module Line_cap = struct
  type t = Js.js_string Js.t

  let butt = Js.string "butt"

  let round = Js.string "round"

  let square = Js.string "square"
end

module Line_join = struct
  type t = Js.js_string Js.t

  let round = Js.string "round"

  let bevel = Js.string "bevel"

  let miter = Js.string "miter"
end

module Interaction_mode = struct
  type t = Js.js_string Js.t

  let point = Js.string "point"

  let nearest = Js.string "nearest"

  let index = Js.string "index"

  let dataset = Js.string "dataset"

  let x = Js.string "x"

  let y = Js.string "y"

  let make s = Js.string s
end

module Point_style = struct
  type t

  let circle = Js.Unsafe.coerce @@ Js.string "circle"

  let cross = Js.Unsafe.coerce @@ Js.string "cross"

  let crossRot = Js.Unsafe.coerce @@ Js.string "crossRot"

  let dash = Js.Unsafe.coerce @@ Js.string "dash"

  let line = Js.Unsafe.coerce @@ Js.string "line"

  let rect = Js.Unsafe.coerce @@ Js.string "rect"

  let rectRounded = Js.Unsafe.coerce @@ Js.string "rectRounded"

  let rectRot = Js.Unsafe.coerce @@ Js.string "rectRot"

  let star = Js.Unsafe.coerce @@ Js.string "star"

  let triangle = Js.Unsafe.coerce @@ Js.string "triangle"

  let of_string s = Js.Unsafe.coerce @@ Js.string s

  let of_image = Js.Unsafe.coerce

  let of_video = Js.Unsafe.coerce

  let of_canvas = Js.Unsafe.coerce

  let element f x =
    Js.Opt.bind (Dom_html.CoerceTo.element (Js.Unsafe.coerce x)) f

  let cast_string x =
    if (Js.typeof x)##toLowerCase == Js.string "string"
    then Js.some (Js.to_string @@ Js.Unsafe.coerce x)
    else Js.null

  let cast_image x = element Dom_html.CoerceTo.img x

  let cast_video x = element Dom_html.CoerceTo.video x

  let cast_canvas x = element Dom_html.CoerceTo.canvas x
end

module Easing = struct
  type t = Js.js_string Js.t

  let linear = Js.string "linear"

  let easeInQuad = Js.string "easeInQuad"

  let easeOutQuad = Js.string "easeOutQuad"

  let easeInOutQuad = Js.string "easeInOutQuad"

  let easeInCubic = Js.string "easeInCubic"

  let easeOutCubic = Js.string "easeOutCubic"

  let easeInOutCubic = Js.string "easeInOutCubic"

  let easeInQuart = Js.string "easeInQuart"

  let easeOutQuart = Js.string "easeOutQuart"

  let easeInOutQuart = Js.string "easeInOutQuart"

  let easeInQuint = Js.string "easeInQuint"

  let easeOutQuint = Js.string "easeOutQuint"

  let easeInOutQuint = Js.string "easeInOutQuint"

  let easeInSine = Js.string "easeInSine"

  let easeOutSine = Js.string "easeOutSine"

  let easeInOutSine = Js.string "easeInOutSine"

  let easeInExpo = Js.string "easeInExpo"

  let easeOutExpo = Js.string "easeOutExpo"

  let easeInOutExpo = Js.string "easeInOutExpo"

  let easeInCirc = Js.string "easeInCirc"

  let easeOutCirc = Js.string "easeOutCirc"

  let easeInOutCirc = Js.string "easeInOutCirc"

  let easeInElastic = Js.string "easeInElastic"

  let easeOutElastic = Js.string "easeOutElastic"

  let easeInOutElastic = Js.string "easeInOutElastic"

  let easeInBack = Js.string "easeInBack"

  let easeOutBack = Js.string "easeOutBack"

  let easeInOutBack = Js.string "easeInOutBack"

  let easeInBounce = Js.string "easeInBounce"

  let easeOutBounce = Js.string "easeOutBounce"

  let easeInOutBounce = Js.string "easeInOutBounce"

  let of_string = Js.string
end

module Padding = struct
  type t

  class type obj = object
    method top : int Js.optdef_prop

    method right : int Js.optdef_prop

    method bottom : int Js.optdef_prop

    method left : int Js.optdef_prop
  end

  let make_object ?top ?right ?bottom ?left () : t Js.t =
    let iter f = function None -> () | Some x -> f x in
    let (obj : obj Js.t) = Js.Unsafe.obj [||] in
    iter (fun x -> obj##.top := x) top;
    iter (fun x -> obj##.right := x) right;
    iter (fun x -> obj##.bottom := x) bottom;
    iter (fun x -> obj##.left := x) left;
    Js.Unsafe.coerce obj

  let of_object = Js.Unsafe.coerce

  let of_int (x : int) : t Js.t =
    Js.Unsafe.coerce @@ Js.number_of_float @@ float_of_int x

  let cast_int (x : t Js.t) : int Js.opt =
    match Js.to_string @@ Js.typeof x with
    | "number" ->
      Js.some
      @@ int_of_float
      @@ Js.float_of_number
      @@ Js.Unsafe.coerce x
    | _ -> Js.null

  let cast_object (x : t Js.t) : obj Js.t Js.opt =
    match Js.to_string @@ Js.typeof x with
    | "object" -> Js.some @@ Js.Unsafe.coerce x
    | _ -> Js.null
end

module Color = struct
  type t

  let of_string s = Js.Unsafe.coerce @@ Js.string s

  let of_canvas_gradient = Js.Unsafe.coerce

  let of_canvas_pattern = Js.Unsafe.coerce

  let cast_string x =
    if (Js.typeof x)##toLowerCase == Js.string "string"
    then Js.some (Js.to_string @@ Js.Unsafe.coerce x)
    else Js.null

  let cast_canvas_gradient _x = Js.null

  let cast_canvas_pattern _x = Js.null
end

module Position = struct
  type t = Js.js_string Js.t

  let left = Js.string "left"

  let right = Js.string "right"

  let top = Js.string "top"

  let bottom = Js.string "bottom"
end

module Tooltip_position = struct
  type t = Js.js_string Js.t

  let average = Js.string "average"

  let nearest = Js.string "nearest"

  let of_string = Js.string
end

module Line_height = struct
  type t

  let of_string s = Js.Unsafe.coerce @@ Js.string s

  let of_float x = Js.Unsafe.coerce @@ Js.number_of_float x

  let cast_string (x : t Js.t) =
    if (Js.typeof x)##toLowerCase == Js.string "string"
    then Js.some (Js.to_string @@ Js.Unsafe.coerce x)
    else Js.null

  let cast_float (x : t Js.t) =
    if (Js.typeof x)##toLowerCase == Js.string "number"
    then Js.some (Js.float_of_number @@ Js.Unsafe.coerce x)
    else Js.null
end

module Hover_axis = struct
  type t = Js.js_string Js.t

  let x = Js.string "x"

  let y = Js.string "y"

  let xy = Js.string "xy"
end

module Fill = struct
  type t

  let zero : t Js.t = Js.Unsafe.coerce @@ Js.string "zero"

  let top : t Js.t = Js.Unsafe.coerce @@ Js.string "top"

  let bottom : t Js.t = Js.Unsafe.coerce @@ Js.string "bottom"

  let _true : t Js.t = Js.Unsafe.coerce Js._true

  let _false : t Js.t = Js.Unsafe.coerce Js._false
end

module Time = struct
  type t = float (* FIXME *)
end

module Or_false = struct
  type 'a t

  let make : 'a. 'a -> 'a t Js.t = fun x -> Obj.magic x

  let _false = Js.Unsafe.coerce Js._false
end

type line_dash = float Js.js_array Js.t

type line_dash_offset = float

module Axis = struct
  type typ = Js.js_string Js.t

  let cartesian_category = Js.string "category"

  let cartesian_linear = Js.string "linear"

  let cartesian_logarithmic = Js.string "logarithmic"

  let cartesian_time = Js.string "time"

  let radial_linear = Js.string "linear"

  let make s = Js.string s
end

module Time_ticks_source = struct
  type t = Js.js_string Js.t

  let auto = Js.string "auto"

  let data = Js.string "data"

  let labels = Js.string "labels"
end

module Time_distribution = struct
  type t = Js.js_string Js.t

  let linear = Js.string "linear"

  let series = Js.string "series"
end

module Time_bounds = struct
  type t = Js.js_string Js.t

  let data = Js.string "data"

  let ticks = Js.string "ticks"
end

module Time_unit = struct
  type t = Js.js_string Js.t

  let millisecond = Js.string "millisecond"

  let second = Js.string "second"

  let minute = Js.string "minute"

  let hour = Js.string "hour"

  let day = Js.string "day"

  let week = Js.string "week"

  let month = Js.string "month"

  let quarter = Js.string "quarter"

  let year = Js.string "year"
end

module Interpolation_mode = struct
  type t = Js.js_string Js.t

  let default = Js.string "default"

  let monotone = Js.string "monotone"
end

module Stepped_line = struct
  type t

  let _false : t Js.t = Js.Unsafe.coerce Js._false

  let _true : t Js.t = Js.Unsafe.coerce Js._true

  let before : t Js.t = Js.Unsafe.coerce @@ Js.string "before"

  let after : t Js.t = Js.Unsafe.coerce @@ Js.string "after"

  let middle : t Js.t = Js.Unsafe.coerce @@ Js.string "middle"
end

module Line_fill = struct
  type t

  let relative (x : int) : t Js.t =
    Js.Unsafe.coerce
    @@ Js.string
    @@ string_of_int x

  let absolute (x : int) : t Js.t =
    Js.Unsafe.coerce
    @@ Js.number_of_float
    @@ float_of_int x

  let _false : t Js.t = Js.Unsafe.coerce Js._false

  let _true : t Js.t = Js.Unsafe.coerce Js._true

  let start : t Js.t = Js.Unsafe.coerce @@ Js.string "start"

  let _end : t Js.t = Js.Unsafe.coerce @@ Js.string "end"

  let origin : t Js.t = Js.Unsafe.coerce @@ Js.string "origin"
end

module Pie_border_align = struct
  type t = Js.js_string Js.t

  let center = Js.string "center"

  let inner = Js.string "inner"
end

type 'a tick_cb = ('a -> int -> 'a Js.js_array Js.t) Js.callback

type ('a, 'b, 'c) tooltip_cb =
  ('a, ('b -> 'c -> Js.js_string Js.t Indexable.t Js.t))
    Js.meth_callback Js.optdef

class type ['x, 'y] dataPoint = object
  method x : 'x Js.prop

  method y : 'y Js.prop
end

class type ['t, 'y] timeDataPoint = object
  method t : 't Js.prop

  method y : 'y Js.prop
end

class type ['x, 'y, 'r] bubbleDataPoint = object
  method x : 'x Js.prop

  method y : 'y Js.prop

  method r : 'r Js.prop
end

class type minorTicks = object
  method callback : 'a tick_cb Js.prop

  method fontColor : Color.t Js.t Js.prop

  method fontFamily : Js.js_string Js.t Js.prop

  method fontSize : int Js.prop

  method fontStyle : Js.js_string Js.t Js.prop
end

and majorTicks = minorTicks

and ticks = object
  method callback : 'a tick_cb Js.prop

  method display : bool Js.t Js.prop

  method fontColor : Color.t Js.t Js.prop

  method fontFamily : Js.js_string Js.t Js.prop

  method fontSize : int Js.prop

  method fontStyle : Js.js_string Js.t Js.prop

  method reverse : bool Js.t Js.prop

  method minor : minorTicks Js.t

  method major : majorTicks Js.t
end

and scaleLabel = object
  method display : bool Js.t Js.prop

  method labelString : Js.js_string Js.t Js.prop

  method lineHeight : Line_height.t Js.t Js.prop

  method fontColor : Color.t Js.t Js.prop

  method fontFamily : Js.js_string Js.t Js.prop

  method fontSize : int Js.prop

  method fontStyle : Js.js_string Js.t Js.prop

  method padding : Padding.t Js.t Js.prop
end

and gridLines = object
  method display : bool Js.t Js.prop

  method circular : bool Js.t Js.prop

  method color : Color.t Js.t Indexable.t Js.t Js.prop

  method borderDash : line_dash Js.prop

  method borderDashOffset : line_dash_offset Js.prop

  method lineWidth : int Indexable.t Js.t Js.prop

  method drawBorder : bool Js.t Js.prop

  method drawOnChartArea : bool Js.t Js.prop

  method drawTicks : bool Js.t Js.prop

  method tickMarkLength : int Js.prop

  method zeroLineWidth : int Js.prop

  method zeroLineColor : int Js.prop

  method zeroLineBorderDash : line_dash Js.prop

  method zeroLineBorderDashOffset : line_dash_offset Js.prop

  method offsetGridLines : bool Js.t Js.prop
end

class type cartesianTicks = object
  inherit ticks

  method autoSkip : bool Js.t Js.prop

  method autoSkipPadding : int Js.prop

  method labelOffset : int Js.prop

  method maxRotation : int Js.prop

  method minRotation : int Js.prop

  method mirror : bool Js.prop

  method padding : int Js.prop
end

class type ['a] cartesianAxis = object
  method _type : Axis.typ Js.optdef_prop

  method position : Position.t Js.prop

  method offset : bool Js.t Js.prop

  method id : Js.js_string Js.t Js.prop

  method gridLines : gridLines Js.t Js.prop

  method scaleLabel : scaleLabel Js.t Js.prop

  method ticks : (#cartesianTicks as 'a) Js.t Js.prop
end

(** {3 Category axis} *)

class type categoryTicks = object
  inherit cartesianTicks

  method labels : Js.js_string Js.t Js.prop

  method min : Js.js_string Js.t Js.optdef_prop

  method max : Js.js_string Js.t Js.optdef_prop
end

and categoryAxis = [categoryTicks] cartesianAxis

class type linearTicks = object
  inherit cartesianTicks

  method beginAtZero : bool Js.t Js.optdef_prop

  method min : float Js.optdef_prop

  method max : float Js.optdef_prop

  method maxTicksLimit : int Js.prop

  method precision : int Js.optdef_prop

  method stepSize : int Js.optdef_prop

  method suggestedMax : float Js.optdef_prop

  method suggestedMin : float Js.optdef_prop
end

and linearAxis = [linearTicks] cartesianAxis

class type logarithmicTicks = object
  inherit cartesianTicks

  method min : float Js.optdef_prop

  method max : float Js.optdef_prop
end

and logarithmicAxis = [logarithmicTicks] cartesianAxis

class type timeDisplayFormats = object
  method millisecond : Js.js_string Js.t Js.prop
  method second : Js.js_string Js.t Js.prop
  method minute : Js.js_string Js.t Js.prop
  method hour : Js.js_string Js.t Js.prop
  method day : Js.js_string Js.t Js.prop
  method week : Js.js_string Js.t Js.prop
  method month : Js.js_string Js.t Js.prop
  method quarter : Js.js_string Js.t Js.prop
  method year : Js.js_string Js.t Js.prop
end

and timeTicks = object
  inherit cartesianTicks

  method source : Time_ticks_source.t Js.prop
end

and timeOptions = object
  method displayFormats : timeDisplayFormats Js.t Js.optdef_prop

  method isoWeekday : bool Js.t Js.prop

  method max : Time.t Js.optdef_prop

  method min : Time.t Js.optdef_prop

  method _parser : unit Js.optdef_prop (* FIXME *)

  method round : Time_unit.t Or_false.t Js.t Js.prop

  method tooltipFormat : Js.js_string Js.t Js.optdef_prop

  method unit : Time_unit.t Or_false.t Js.t Js.prop

  method stepSize : int Js.prop

  method minUnit : Time_unit.t Js.prop
end

and timeAxis = object
  inherit [timeTicks] cartesianAxis

  method time : timeOptions Js.t Js.prop

  method distribution : Time_distribution.t Js.prop

  method bounds : Time_bounds.t Js.prop
end

class type scales = object
  method xAxes : 'a Js.t Js.js_array Js.t Js.optdef_prop

  method yAxes : 'a Js.t Js.js_array Js.t Js.optdef_prop
end

class type dataset = object
  method _type : Js.js_string Js.t Js.optdef_prop

  method label : Js.js_string Js.t Js.optdef_prop
end

class type data = object
  method datasets : dataset Js.t Js.js_array Js.t Js.prop

  method labels : Js.js_string Js.t Js.js_array Js.t Js.optdef_prop

  method xLabels : Js.js_string Js.t Js.js_array Js.t Js.optdef_prop

  method yLabels : Js.js_string Js.t Js.js_array Js.t Js.optdef_prop
end

let createData ?(datasets = []) ?labels ?xLabels ?yLabels () =
  let iter f = function None -> () | Some x -> f x in
  let map_labels x = Js.array @@ Array.of_list @@ List.map Js.string x in
  let (obj : data Js.t) = Js.Unsafe.obj [||] in
  iter (fun x -> obj##.labels := map_labels x) labels;
  iter (fun x -> obj##.xLabels := map_labels x) xLabels;
  iter (fun x -> obj##.yLabels := map_labels x) yLabels;
  let datasets =
    Js.array
    @@ Array.of_list
    @@ List.map (fun x -> (x :> dataset Js.t)) datasets in
  obj##.datasets := datasets;
  obj

class type ['chart] animationItem = object
  method chart : 'chart Js.t Js.readonly_prop

  method currentStep : float Js.readonly_prop

  method numSteps : float Js.readonly_prop

  method render : 'chart Js.t -> 'chart animationItem Js.t -> unit Js.meth

  method onAnimationProgress : 'chart animationItem Js.t -> unit Js.meth

  method onAnimationComplete : 'chart animationItem Js.t -> unit Js.meth
end

class type ['chart] animation = object
  method duration : int Js.prop

  method easing : Easing.t Js.prop

  method onProgress : ('chart animationItem Js.t -> unit) Js.callback Js.opt Js.prop

  method onComplete : ('chart animationItem Js.t -> unit) Js.callback Js.opt Js.prop
end

let createAnimation () = Js.Unsafe.obj [||]

class type layout = object
  method padding : Padding.t Js.prop
end

let createLayout () = Js.Unsafe.obj [||]

class type legendItem = object
  method text : Js.js_string Js.t Js.prop

  method fillStyle : Color.t Js.t Js.prop

  method hidden : bool Js.t Js.prop

  method lineCap : Line_cap.t Js.optdef_prop

  method lineDash : line_dash Js.optdef_prop

  method lineDashOffset : line_dash_offset Js.optdef_prop

  method lineJoin : Line_join.t Js.optdef_prop

  method lineWidth : int Js.prop

  method strokeStyle : Color.t Js.t Js.prop

  method pointStyle : Point_style.t Js.t Js.optdef_prop

  method datasetIndex : int Js.prop
end

class type ['chart] legendLabels = object('self)
  method boxWidth : int Js.prop

  method fontSize : int Js.optdef_prop

  method fontStyle : Js.js_string Js.t Js.optdef_prop

  method fontColor : Color.t Js.t Js.optdef_prop

  method fontFamily : Js.js_string Js.t Js.optdef_prop

  method padding : int Js.prop

  method generateLabels :
    ('chart Js.t
     -> legendItem Js.t Js.js_array Js.t) Js.callback Js.prop

  method filter :
    ('self,
     legendItem Js.t
     -> data Js.t
     -> bool Js.t) Js.meth_callback Js.optdef_prop

  method usePointStyle : bool Js.t Js.optdef_prop
end

class type ['chart] legend = object
  method display : bool Js.t Js.prop

  method position : Position.t Js.prop

  method fullWidth : bool Js.t Js.prop

  method onClick :
    ('chart,
     Dom_html.event Js.t
     -> legendItem Js.t
     -> unit) Js.meth_callback Js.optdef_prop

  method onHover :
    ('chart,
     Dom_html.event Js.t
     -> legendItem Js.t
     -> unit) Js.meth_callback Js.optdef_prop

  method onLeave :
    ('chart,
     Dom_html.event Js.t
     -> legendItem Js.t
     -> unit) Js.meth_callback Js.optdef_prop

  method reverse : bool Js.t Js.prop

  method labels : 'chart legendLabels Js.t Js.prop
end

let createLegendLabels () = Js.Unsafe.obj [||]

let createLegend () = Js.Unsafe.obj [||]

class type title = object
  method display : bool Js.t Js.prop

  method position : Position.t Js.prop

  method fontSize : int Js.optdef_prop

  method fontFamily : Js.js_string Js.t Js.optdef_prop

  method fontColor : Js.js_string Js.t Js.optdef_prop

  method fontStyle : Js.js_string Js.t Js.optdef_prop

  method fullWidth : bool Js.t Js.prop

  method padding : int Js.prop

  method lineHeight : Line_height.t Js.t Js.optdef_prop

  method text : Js.js_string Js.t Indexable.t Js.t Js.prop
end

let createTitle () = Js.Unsafe.obj [||]

class type tooltipItem = object
  method label : Js.js_string Js.t Js.readonly_prop

  method value : Js.js_string Js.t Js.readonly_prop

  method datasetIndex : int Js.readonly_prop

  method index : int Js.readonly_prop

  method x : float Js.readonly_prop

  method y : float Js.readonly_prop
end

and tooltipBodyLines = object
  method before : Js.js_string Js.t Js.js_array Js.t Js.readonly_prop

  method lines : Js.js_string Js.t Js.js_array Js.t Js.readonly_prop

  method after : Js.js_string Js.t Js.js_array Js.t Js.readonly_prop
end

and tooltipModel = object
  method dataPoints : tooltipItem Js.t Js.js_array Js.t Js.readonly_prop

  method xPadding : int Js.readonly_prop

  method yPadding : int Js.readonly_prop

  method xAlign : Js.js_string Js.t Js.readonly_prop

  method yAlign : Js.js_string Js.t Js.readonly_prop

  method x : float Js.readonly_prop

  method y : float Js.readonly_prop

  method width : float Js.readonly_prop

  method height : float Js.readonly_prop

  method caretX : int Js.readonly_prop

  method caretY : int Js.readonly_prop

  method body : tooltipBodyLines Js.t Js.readonly_prop

  method beforeBody : Js.js_string Js.t Js.js_array Js.t Js.readonly_prop

  method afterBody : Js.js_string Js.t Js.js_array Js.t Js.readonly_prop

  method bodyFontColor : Color.t Js.t Js.readonly_prop

  method __bodyFontFamily : Js.js_string Js.t Js.readonly_prop

  method __bodyFontStyle : Js.js_string Js.t Js.readonly_prop

  method __bodyAlign : Js.js_string Js.t Js.readonly_prop

  method bodyFontSize : int Js.readonly_prop

  method bodySpacing : int Js.readonly_prop

  method title : Js.js_string Js.t Indexable.t Js.readonly_prop

  method titleFontColor : Color.t Js.t Js.readonly_prop

  method __titleFontFamily : Js.js_string Js.t Js.readonly_prop

  method __titleFontStyle : Js.js_string Js.t Js.readonly_prop

  method titleFontSize : int Js.readonly_prop

  method __titleAlign : Js.js_string Js.t Js.readonly_prop

  method titleSpacing : int Js.readonly_prop

  method titleMarginBottom : int Js.readonly_prop

  method footer : Js.js_string Js.t Indexable.t Js.readonly_prop

  method footerFontColor : Color.t Js.t Js.readonly_prop

  method __footerFontFamily : Js.js_string Js.t Js.readonly_prop

  method __footerFontStyle : Js.js_string Js.t Js.readonly_prop

  method footerFontSize : int Js.readonly_prop

  method __footerAlign : Js.js_string Js.t Js.readonly_prop

  method footerSpacing : int Js.readonly_prop

  method footerMarginTop : int Js.readonly_prop

  method caretSize : int Js.readonly_prop

  method caretPadding : int Js.readonly_prop

  method cornerRadius : int Js.readonly_prop

  method backgroundColor : Color.t Js.t Js.readonly_prop

  method labelColors : Color.t Js.t Js.js_array Js.t Js.readonly_prop

  method labelTextColors : Color.t Js.t Js.js_array Js.t Js.readonly_prop

  method opacity : float Js.readonly_prop

  method legendColorBackground : Color.t Js.t Js.readonly_prop

  method displayColors : bool Js.t Js.readonly_prop

  method borderColor : Color.t Js.t Js.readonly_prop

  method borderWidth : int Js.readonly_prop
end

and ['chart] tooltipCallbacks = object
  method beforeTitle :
    ('chart tooltip Js.t,
     tooltipItem Js.js_array Js.t,
     data Js.t) tooltip_cb Js.prop

  method title :
    ('chart tooltip Js.t,
     tooltipItem Js.js_array Js.t,
     data Js.t) tooltip_cb Js.prop

  method afterTitle :
    ('chart tooltip Js.t,
     tooltipItem Js.js_array Js.t,
     data Js.t) tooltip_cb Js.prop

  method beforeBody :
    ('chart tooltip Js.t,
     tooltipItem Js.js_array Js.t,
     data Js.t) tooltip_cb Js.prop

  method beforeLabel :
    ('chart tooltip Js.t,
     tooltipItem Js.t,
     data Js.t) tooltip_cb Js.prop

  method label :
    ('chart tooltip Js.t,
     tooltipItem Js.t,
     data Js.t) tooltip_cb Js.prop

  method labelColor :
    ('chart tooltip Js.t,
     tooltipItem Js.t,
     'chart Js.t) tooltip_cb Js.prop

  method labelTextColor :
    ('chart tooltip Js.t,
     tooltipItem Js.t,
     'chart Js.t) tooltip_cb Js.prop

  method afterLabel :
    ('chart tooltip Js.t,
     tooltipItem Js.t,
     data Js.t) tooltip_cb Js.prop

  method afterBody :
    ('chart tooltip Js.t,
     tooltipItem Js.t Js.js_array Js.t,
     data Js.t) tooltip_cb Js.prop

  method beforeFooter :
    ('chart tooltip Js.t,
     tooltipItem Js.js_array Js.t,
     data Js.t) tooltip_cb Js.prop

  method footer :
    ('chart tooltip Js.t,
     tooltipItem Js.js_array Js.t,
     data Js.t) tooltip_cb Js.prop

  method afterFooter :
    ('chart tooltip Js.t,
     tooltipItem Js.js_array Js.t,
     data Js.t) tooltip_cb Js.prop

end

and ['chart] tooltip = object('self)
  method enabled : bool Js.t Js.prop

  method custom : (tooltipModel Js.t -> unit) Js.callback Js.opt Js.prop

  method mode : Interaction_mode.t Js.prop

  method intersect : bool Js.t Js.prop

  method position : Tooltip_position.t Js.prop

  method callbacks : 'chart tooltipCallbacks Js.t Js.prop

  method itemSort :
    ('self,
     tooltipItem Js.t
     -> tooltipItem Js.t
     -> data Js.t
     -> int) Js.meth_callback Js.optdef_prop

  method filter :
    ('self,
     tooltipItem Js.t
     -> data Js.t
     -> bool Js.t) Js.meth_callback Js.optdef_prop

  method backgroundColor : Color.t Js.t Js.prop

  method titleFontFamily : Js.js_string Js.t Js.optdef_prop

  method titleFontSize : int Js.optdef_prop

  method titleFontStyle : Js.js_string Js.t Js.optdef_prop

  method titleFontColor : Color.t Js.t Js.optdef_prop

  method titleSpacing : int Js.prop

  method titleMarginBottom : int Js.prop

  method bodyFontFamily : Js.js_string Js.t Js.optdef_prop

  method bodyFontSize : int Js.optdef_prop

  method bodyFontStyle : Js.js_string Js.t Js.optdef_prop

  method bodyFontColor : Color.t Js.t Js.optdef_prop

  method bodySpacing : int Js.prop

  method footerFontFamily : Js.js_string Js.t Js.optdef_prop

  method footerFontSize : int Js.optdef_prop

  method footerFontStyle : Js.js_string Js.t Js.optdef_prop

  method footerFontColor : Color.t Js.t Js.optdef_prop

  method footerSpacing : int Js.prop

  method footerMarginTop : int Js.prop

  method xPadding : int Js.prop

  method yPadding : int Js.prop

  method caretPadding : int Js.prop

  method caretSize : int Js.prop

  method cornerRadius : int Js.prop

  method multyKeyBackground : Color.t Js.t Js.prop

  method displayColors : bool Js.t Js.prop

  method borderColor : Color.t Js.t Js.prop

  method borderWidth : int Js.prop
end

let createTooltip () = Js.Unsafe.obj [||]

class type hover = object
  method mode : Interaction_mode.t Js.prop

  method intersect : bool Js.t Js.prop

  method axis : Hover_axis.t Js.prop

  method animationDuration : int Js.prop
end

let createHover () = Js.Unsafe.obj [||]

class type pointElement = object
  method radius : int Js.prop

  method pointStyle : Point_style.t Js.t Js.prop

  method rotation : int Js.optdef_prop

  method backgroundColor : Color.t Js.t Js.prop

  method borderWidth : int Js.prop

  method borderColor : Color.t Js.t Js.prop

  method hitRadius : int Js.prop

  method hoverRadius : int Js.prop

  method hoverBorderWidth : int Js.prop
end

class type lineElement = object
  method tension : float Js.prop

  method backgroundColor : Color.t Js.t Js.prop

  method borderWidth : int Js.prop

  method borderColor : Color.t Js.t Js.prop

  method borderCapStyle : Line_cap.t Js.prop

  method borderDash : line_dash Js.prop

  method borderDashOffset : line_dash_offset Js.prop

  method borderJoinStyle : Line_join.t Js.prop

  method capBezierPoints : bool Js.t Js.prop

  method fill : Fill.t Js.t Js.prop

  method stepped : bool Js.t Js.optdef_prop
end

class type rectangleElement = object
  method backgroundColor : Js.js_string Js.prop

  method borderWidth : int Js.prop

  method borderColor : Color.t Js.t Js.prop

  method borderSkipped : Position.t Js.prop
end

class type arcElement = object
  method backgroundColor : Color.t Js.t Js.prop

  method borderAlign : Js.js_string Js.t Js.prop

  method borderColor : Color.t Js.t Js.prop

  method borderWidth : int Js.prop
end

class type elements = object
  method point : pointElement Js.t Js.prop

  method line : lineElement Js.t Js.prop

  method rectangle : rectangleElement Js.t Js.prop

  method arc : arcElement Js.t Js.prop
end

let createPointElement () = Js.Unsafe.obj [||]

let createLineElement () = Js.Unsafe.obj [||]

let createRectangleElement () = Js.Unsafe.obj [||]

let createArcElement () = Js.Unsafe.obj [||]

let createElements () = Js.Unsafe.obj [||]

class type chartSize = object
  method width : int Js.readonly_prop

  method height : int Js.readonly_prop
end

class type updateConfig = object
  method duration : int Js.optdef_prop

  method _lazy : bool Js.t Js.optdef_prop

  method easing : Easing.t Js.optdef_prop
end

let createUpdateConfig ?duration ?_lazy ?easing () : updateConfig Js.t =
  let iter f = function None -> () | Some x -> f x in
  let (conf : updateConfig Js.t) = Js.Unsafe.obj [||] in
  iter (fun x -> conf##.duration := x) duration;
  iter (fun x -> conf##._lazy := Js.bool x) _lazy;
  iter (fun x -> conf##.easing := x) easing;
  conf

class type ['chart, 'animation] chartOptions = object
  constraint 'animation = 'chart #animation

  method animation : 'animation Js.t Js.prop

  method layout : layout Js.t Js.prop

  method legend : 'chart legend Js.t Js.prop

  method title : title Js.t Js.prop

  method tooltips : 'chart tooltip Js.t Js.prop

  method elements : elements Js.t Js.prop

  method plugins : 'a Js.t Js.prop

  method legendCallback : ('chart Js.t -> Js.js_string Js.t) Js.callback Js.optdef_prop

  method responsive : bool Js.t Js.prop

  method responsiveAnimationDuration : int Js.prop

  method maintainAspectRatio : bool Js.t Js.prop

  method aspectRatio : float Js.optdef_prop

  method onResize :
    ('chart Js.t
     -> chartSize Js.t
     -> unit) Js.callback Js.opt Js.optdef_prop

  method devicePixelRatio : float Js.optdef_prop

  method events : Js.js_string Js.t Js.js_array Js.t Js.prop

  method onHover :
    ('chart Js.t,
     Dom_html.event Js.t
     -> 'a Js.t Js.js_array Js.t
     -> unit)
      Js.meth_callback Js.opt Js.optdef_prop

  method onClick :
    ('chart Js.t,
     Dom_html.event Js.t
     -> 'a Js.t Js.js_array Js.t
     -> unit)
      Js.meth_callback Js.opt Js.optdef_prop
end

class type ['a] chartConfig = object
  method data : data Js.t Js.prop

  method options : 'a Js.t Js.prop

  method _type : Js.js_string Js.t Js.prop
end

class type ['a] chart = object('self)
  method id : int Js.readonly_prop

  method height : int Js.readonly_prop

  method width : int Js.readonly_prop

  method offsetX : int Js.readonly_prop

  method offsetY : int Js.readonly_prop

  method borderWidth : int Js.readonly_prop

  method animating : bool Js.t Js.readonly_prop

  method aspectRatio : float Js.readonly_prop

  method canvas : Dom_html.canvasElement Js.t Js.readonly_prop

  method ctx : Dom_html.canvasRenderingContext2D Js.t Js.readonly_prop

  method options : 'a Js.t Js.prop

  method config : 'a chartConfig Js.t Js.prop

  method data : data Js.t Js.prop

  method destroy : unit Js.meth

  method update : unit Js.meth

  method update_withConfig : #updateConfig Js.t -> unit Js.meth

  method reset : unit Js.meth

  method render : unit Js.meth

  method render_withConfig : #updateConfig Js.t -> unit Js.meth

  method stop : 'self Js.t Js.meth

  method resize : 'self Js.t Js.meth

  method clear : 'self Js.t Js.meth

  method toBase64Image : Js.js_string Js.t Js.meth

  method generateLegend : Js.js_string Js.t Js.meth
end

class type ['a] lineOptionContext = object
  method chart : lineChart Js.t Js.readonly_prop

  method dataIndex : int Js.readonly_prop

  method dataset : 'a lineDataset Js.t Js.readonly_prop

  method datasetIndex : int Js.readonly_prop
end

and lineOptions = object
  inherit [lineChart, lineChart animation] chartOptions

  method showLines : bool Js.t Js.prop

  method spanGaps : bool Js.t Js.prop
end

and ['a] lineDataset = object
  inherit dataset

  method data : 'a Js.js_array Js.t Js.prop

  method xAxisID : Js.js_string Js.t Js.optdef_prop

  method yAxisID : Js.js_string Js.t Js.optdef_prop

  method pointBackgroundColor :
    ('a lineOptionContext Js.t, Color.t Js.t) Scriptable_indexable.t Js.t Js.optdef_prop

  method pointBorderColor :
    ('a lineOptionContext Js.t, Color.t Js.t) Scriptable_indexable.t Js.t Js.optdef_prop

  method pointBorderWidth :
    ('a lineOptionContext Js.t, int) Scriptable_indexable.t Js.t Js.optdef_prop

  method pointHitRadius :
    ('a lineOptionContext Js.t, int) Scriptable_indexable.t Js.t Js.optdef_prop

  method pointRadius :
    ('a lineOptionContext Js.t, int) Scriptable_indexable.t Js.t Js.optdef_prop

  method pointRotation :
    ('a lineOptionContext Js.t, int) Scriptable_indexable.t Js.t Js.optdef_prop

  method pointStyle : Point_style.t Js.t Js.optdef_prop

  method backgroundColor : Color.t Js.t Js.optdef_prop

  method borderCapStyle : Line_cap.t Js.optdef_prop

  method borderColor : Color.t Js.t Js.optdef_prop

  method borderDash : line_dash Js.optdef_prop

  method borderDashOffset : line_dash_offset Js.optdef_prop

  method borderJoinStyle : Line_join.t Js.optdef_prop

  method borderWidth : int Js.optdef_prop

  method fill : Line_fill.t Js.t Js.optdef_prop

  method lineTension : float Js.optdef_prop

  method showLine : bool Js.t Js.optdef_prop

  method spanGaps : bool Js.t Js.optdef_prop

  method pointHoverBackgroundColor :
    ('a lineOptionContext Js.t, Color.t Js.t) Scriptable_indexable.t Js.t Js.optdef_prop

  method pointHoverBorderColor :
    ('a lineOptionContext Js.t, Color.t Js.t) Scriptable_indexable.t Js.t Js.optdef_prop

  method pointHoverBorderWidth :
    ('a lineOptionContext Js.t, int) Scriptable_indexable.t Js.t Js.optdef_prop

  method pointHoverRadius :
    ('a lineOptionContext Js.t, int) Scriptable_indexable.t Js.t Js.optdef_prop

  method cubicInterpolationMode : Interpolation_mode.t Js.optdef_prop

  method steppedLine : Stepped_line.t Js.t Js.optdef_prop
end

and lineChart = object
  inherit [lineOptions] chart
end

let createLineOptions () = Js.Unsafe.obj [||]

let createLineDataset data : 'a lineDataset Js.t =
  let (lineDataset : 'a lineDataset Js.t) = Js.Unsafe.obj [||] in
  lineDataset##.data := data;
  lineDataset

class type ['a] barOptionContext = object
  method chart : barChart Js.t Js.readonly_prop

  method dataIndex : int Js.readonly_prop

  method dataset : 'a barDataset Js.t Js.readonly_prop

  method datasetIndex : int Js.readonly_prop
end

and barScale = object
  method barPercentage : float Js.prop

  method categoryPercentage : float Js.prop

  method barThickness : float Js.optdef_prop (* FIXME *)

  method maxBarThickness : float Js.optdef_prop

  method minBarLength : float Js.optdef_prop
end

and barOptions = object
  inherit [barChart, barChart animation] chartOptions
end

and ['a] barDataset = object
  inherit dataset

  method data : 'a Js.js_array Js.t Js.prop

  method xAxisID : Js.js_string Js.t Js.optdef_prop

  method yAxisID : Js.js_string Js.t Js.optdef_prop

  method backgroundColor :
    ('a barOptionContext Js.t, Color.t Js.t) Scriptable_indexable.t Js.t Js.optdef_prop

  method borderColor :
    ('a barOptionContext Js.t, Color.t Js.t) Scriptable_indexable.t Js.t Js.optdef_prop

  method borderSkipped :
    ('a barOptionContext Js.t, Position.t Or_false.t Js.t) Scriptable_indexable.t Js.t
      Js.optdef_prop

  method borderWidth :
    ('a barOptionContext Js.t, Padding.t Js.t) Scriptable_indexable.t
      Js.t Js.optdef_prop

  method hoverBackgroundColor : Color.t Js.t Indexable.t Js.t Js.optdef_prop

  method hoverBorderColor : Color.t Js.t Indexable.t Js.t Js.optdef_prop

  method hoverBorderWidth : Color.t Js.t Indexable.t Js.t Js.optdef_prop
end

and barChart = object
  inherit [barOptions] chart
end

let createBarOptions () = Js.Unsafe.obj [||]

let createBarDataset data : 'a barDataset Js.t =
  let (barDataset : 'a barDataset Js.t) = Js.Unsafe.obj [||] in
  barDataset##.data := data;
  barDataset

class type ['a] pieOptionContext = object
  method chart : pieChart Js.t Js.readonly_prop

  method dataIndex : int Js.readonly_prop

  method dataset : 'a pieDataset Js.t Js.readonly_prop

  method datasetIndex : int Js.readonly_prop
end

and pieAnimation = object
  inherit [pieChart] animation

  method animateRotate : bool Js.t Js.prop

  method animateScale : bool Js.t Js.prop
end

and pieOptions = object
  inherit [pieChart, pieAnimation] chartOptions

  method cutoutPercentage : float Js.prop

  method rotation : float Js.prop

  method circumference : float Js.prop
end

and ['a] pieDataset = object
  inherit dataset

  method data : 'a Js.js_array Js.t Js.prop

  method backgroundColor :
    ('a pieOptionContext Js.t, Color.t Js.t) Scriptable_indexable.t Js.t Js.optdef_prop

  method borderColor :
    ('a pieOptionContext Js.t, Color.t Js.t) Scriptable_indexable.t Js.t Js.optdef_prop

  method borderWidth :
    ('a pieOptionContext Js.t, int) Scriptable_indexable.t Js.t Js.optdef_prop

  method weight : float Js.optdef_prop

  method hoverBackgroundColor :
    ('a pieOptionContext Js.t, Color.t Js.t) Scriptable_indexable.t Js.t Js.optdef_prop

  method hoverBorderColor :
    ('a pieOptionContext Js.t, Color.t Js.t) Scriptable_indexable.t Js.t Js.optdef_prop

  method hoverBorderWidth :
    ('a pieOptionContext Js.t, int) Scriptable_indexable.t Js.t Js.optdef_prop

  method borderAlign : Pie_border_align.t Js.optdef_prop
end

and pieChart = object
  inherit [pieOptions] chart
end

let createPieAnimation () = Js.Unsafe.obj [||]

let createPieOptions () = Js.Unsafe.obj [||]

let createPieDataset data : 'a pieDataset Js.t =
  let (pieDataset : 'a pieDataset Js.t) = Js.Unsafe.coerce @@ Js.Unsafe.obj [||] in
  pieDataset##.data := data;
  pieDataset

module Chart = struct
  type 'a typ = Js.js_string Js.t

  let line = Js.string "line"

  let bar = Js.string "bar"

  let horizontal_bar = Js.string "horizontalBar"

  let pie = Js.string "pie"

  let doughnut = Js.string "doughnut"

  let make s = Js.string s
end

module CoerceTo = struct
  let unsafe_coerce_chart typ (chart : 'a #chart Js.t) =
    if (Js.Unsafe.coerce chart)##.config##._type##toLowerCase == Js.string typ
    then Js.some (Js.Unsafe.coerce chart)
    else Js.null

  let line c = unsafe_coerce_chart "line" c

  let bar c = unsafe_coerce_chart "bar" c

  let horizontalBar c = unsafe_coerce_chart "horizontalBar" c

  let pie c = unsafe_coerce_chart "pie" c

  let doughnut c = unsafe_coerce_chart "doughnut" c
end

let chart_constr = Js.Unsafe.global##._Chart

let chart_from_canvas typ data options (canvas : Dom_html.canvasElement Js.t) =
  let config : 'a chartConfig Js.t = object%js
    val mutable _type = typ
    val mutable data = data
    val mutable options = options
  end in
  new%js chart_constr canvas config

let chart_from_ctx typ data options (ctx : Dom_html.canvasRenderingContext2D Js.t) =
  let config : 'a chartConfig Js.t = object%js
    val mutable _type = typ
    val mutable data = data
    val mutable options = options
  end in
  new%js chart_constr ctx config

let chart_from_id typ data options (id : string) =
  let config : 'a chartConfig Js.t = object%js
    val mutable _type = typ
    val mutable data = data
    val mutable options = options
  end in
  new%js chart_constr (Js.string id) config
