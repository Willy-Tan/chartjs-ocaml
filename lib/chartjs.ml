open Js_of_ocaml

module Indexable = struct
  (** Indexable type represents a single value or a list of values *)
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

  let cast_array (t : 'a t Js.t) : 'a Js.js_array Js.t Js.opt =
    if Js.instanceof t Js.array_empty
    then Js.some (Js.Unsafe.coerce t)
    else Js.null

  let cast (t : 'a t Js.t) : [`Single of 'a | `Array of 'a Js.js_array Js.t] =
    Js.Opt.case (cast_array t)
      (fun () -> `Single (Obj.magic t))
      (fun x -> `Array x)
end

module Scriptable = struct
  type 'a t
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
end

module Point_style = struct
  type t = Js.js_string Js.t

  let circle = Js.string "circle"
  let cross = Js.string "cross"
  let crossRot = Js.string "crossRot"
  let dash = Js.string "dash"
  let line = Js.string "line"
  let rect = Js.string "rect"
  let rectRounded = Js.string "rectRounded"
  let rectRot = Js.string "rectRot"
  let star = Js.string "star"
  let triangle = Js.string "triangle"
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
end

module Padding = struct
  type t

  class type obj = object
    method top : int Js.prop
    method right : int Js.prop
    method bottom : int Js.prop
    method left : int Js.prop
  end

  let make ~top ~right ~bottom ~left : t Js.t =
    let (obj : obj Js.t) = object%js
      val mutable top = top
      val mutable right = right
      val mutable bottom = bottom
      val mutable left = left
    end in
    Js.Unsafe.coerce obj

  let int (x : int) : t Js.t =
    Js.Unsafe.coerce @@ Js.number_of_float @@ float_of_int x

  let obj (x : obj Js.t) : t Js.t =
    Js.Unsafe.coerce x

  let cast_int (x : t Js.t) : int Js.opt =
    match Js.to_string @@ Js.typeof x with
    | "number" ->
      Js.some
      @@ int_of_float
      @@ Js.float_of_number
      @@ Js.Unsafe.coerce x
    | _ -> Js.null

  let cast_obj (x : t Js.t) : obj Js.t Js.opt =
    match Js.to_string @@ Js.typeof x with
    | "object" -> Js.some @@ Js.Unsafe.coerce x
    | _ -> Js.null
end

module Color = struct
  type t = Js.js_string Js.t
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
end

(* FIXME *)
module Line_height = struct
  type t = int
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
  type t = float
end

module Or_false = struct
  type 'a t
  let make : 'a. 'a -> 'a t Js.t = fun x -> Obj.magic x
  let _false = Js.Unsafe.coerce Js._false
end

type line_dash = float Js.js_array Js.t

type line_dash_offset = float

module Chart_type = struct
  type 'a t = Js.js_string Js.t

  let line = Js.string "line"
  let bar = Js.string "bar"
  let horizontal_bar = Js.string "horizontalBar"

  (* TODO implement *)

  (* let radar = Js.string "radar"
   * let doughnut = Js.string "doughnut"
   * let pie = Js.string "pie"
   * let polar_area = Js.string "polarArea"
   * let bubble = Js.string "bubble"
   * let scatter = Js.string "scatter" *)

  let make s = Js.string s
end

module Axis_type = struct
  type t = Js.js_string Js.t

  let cartesian_category = Js.string "category"
  let cartesian_linear = Js.string "linear"
  let cartesian_logarithmic = Js.string "logarithmic"
  let cartesian_time = Js.string "time"

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
  (** Equivalent to [origin] *)

  let start : t Js.t = Js.Unsafe.coerce @@ Js.string "start"
  let _end : t Js.t = Js.Unsafe.coerce @@ Js.string "end"
  let origin : t Js.t = Js.Unsafe.coerce @@ Js.string "origin"
end

type 'a tick_cb = ('a -> int -> 'a Js.js_array Js.t) Js.callback

type ('a, 'b, 'c) tooltip_cb =
  ('a, ('b -> 'c -> Js.js_string Js.t Indexable.t Js.t))
    Js.meth_callback Js.optdef

(** {1 Axes} *)

(** The minorTick configuration is nested under the ticks configuration
    in the [minor] key. It defines options for the minor tick marks that are
    generated by the axis. Omitted options are inherited from ticks
    configuration. *)
class type minorTicks = object

  method callback : 'a tick_cb Js.prop
  (** Returns the string representation of the tick value
      as it should be displayed on the chart. *)

  method fontColor : Color.t Js.prop
  (** Font color for tick labels. *)

  method fontFamily : Js.js_string Js.t Js.prop
  (** Font family for the tick labels, follows CSS font-family options. *)

  method fontSize : int Js.prop
  (** Font size for the tick labels. *)

  method fontStyle : Js.js_string Js.t Js.prop
  (** Font style for the tick labels, follows CSS font-style options
      (i.e. normal, italic, oblique, initial, inherit). *)

end

(** The majorTick configuration is nested under the ticks configuration
    in the [major] key. It defines options for the major tick marks that are
    generated by the axis. Omitted options are inherited from ticks configuration.
    These options are disabled by default. *)
and majorTicks = minorTicks

(** The tick configuration is nested under the scale configuration
    in the ticks key. It defines options for the tick marks that are
    generated by the axis.*)
and ticks = object

  method callback : 'a tick_cb Js.prop
  (** Returns the string representation of the tick value as
      it should be displayed on the chart. *)

  method display : bool Js.t Js.prop
  (** If [true], show tick marks. *)

  method fontColor : Color.t Js.prop
  (** Font color for tick labels. *)

  method fontFamily : Js.js_string Js.t Js.prop
  (** Font family for the tick labels, follows CSS font-family options. *)

  method fontSize : int Js.prop
  (** Font size for the tick labels. *)

  method fontStyle : Js.js_string Js.t Js.prop
  (** Font style for the tick labels, follows CSS font-style options
      (i.e. normal, italic, oblique, initial, inherit). *)

  method reverse : bool Js.t Js.prop
  (** Reverses order of tick labels. *)

  method minor : minorTicks Js.t
  (** Minor ticks configuration. Omitted options are inherited
      from options above. *)

  method major : majorTicks Js.t
  (** Major ticks configuration. Omitted options are inherited
      from options above.*)

end

and scaleLabel = object

  method display : bool Js.t Js.prop
  (** If true, display the axis title. *)

  method labelString : Js.js_string Js.t Js.prop
  (** The text for the title. (i.e. "# of People" or "Response Choices"). *)

  method lineHeight : Line_height.t Js.prop
  (** Height of an individual line of text. *)

  method fontColor : Color.t Js.prop
  (** Font color for scale title. *)

  method fontFamily : Js.js_string Js.t Js.prop
  (** Font family for the scale title, follows CSS font-family options. *)

  method fontSize : int Js.prop
  (** Font size for scale title. *)

  method fontStyle : Js.js_string Js.t Js.prop
  (** Font style for the scale title, follows CSS font-style options
      (i.e. normal, italic, oblique, initial, inherit) *)

  method padding : Padding.t Js.t Js.prop
  (** Padding to apply around scale labels.
      Only top and bottom are implemented. *)

end

and gridLines = object

  method display : bool Js.t Js.prop
  (** If [false], do not display grid lines for this axis. *)

  method circular : bool Js.t Js.prop
  (** If [true], gridlines are circular (on radar chart only). *)

  method color : Color.t Js.t Indexable.t Js.t Js.prop
  (** The color of the grid lines. If specified as an array,
      the first color applies to the first grid line, the second
      to the second grid line and so on. *)

  method borderDash : line_dash Js.prop
  (** Length and spacing of dashes on grid lines. *)

  method borderDashOffset : line_dash_offset Js.prop
  (** Offset for line dashes. *)

  method lineWidth : int Indexable.t Js.t Js.prop
  (** Stroke width of grid lines. *)

  method drawBorder : bool Js.t Js.prop
  (** If true, draw border at the edge between the axis and the chart area. *)

  method drawOnChartArea : bool Js.t Js.prop
  (** If true, draw lines on the chart area inside the axis lines.
      This is useful when there are multiple axes and you need to
      control which grid lines are drawn. *)

  method drawTicks : bool Js.t Js.prop
  (** If true, draw lines beside the ticks in the axis area beside the chart. *)

  method tickMarkLength : int Js.prop
  (** Length in pixels that the grid lines will draw into the axis area. *)

  method zeroLineWidth : int Js.prop
  (** Stroke width of the grid line for the first index (index 0). *)

  method zeroLineColor : int Js.prop
  (** Stroke color of the grid line for the first index (index 0). *)

  method zeroLineBorderDash : line_dash Js.prop
  (** Length and spacing of dashes of the grid line
      for the first index (index 0). *)

  method zeroLineBorderDashOffset : line_dash_offset Js.prop
  (** Offset for line dashes of the grid line for the first index (index 0). *)

  method offsetGridLines : bool Js.t Js.prop
  (** If [true], grid lines will be shifted to be between labels.
      This is set to true for a category scale in a bar chart by default. *)

end

(** {2 Cartesian axes} *)

(** {3 Base types for cartesian axis} *)

class type cartesianTicks = object
  inherit ticks

  method autoSkip : bool Js.t Js.prop
  (** If [true], automatically calculates how many labels that
      can be shown and hides labels accordingly. Turn it off to show all
      labels no matter what. *)

  method autoSkipPadding : int Js.prop
  (** Padding between the ticks on the horizontal axis when autoSkip is
      enabled. Note: Only applicable to horizontal scales. *)

  method labelOffset : int Js.prop
  (** Distance in pixels to offset the label from the centre point of the
      tick (in the y direction for the x axis, and the x direction for the
      y axis). Note: this can cause labels at the edges to be cropped by the
      edge of the canvas. *)

  method maxRotation : int Js.prop
  (** Maximum rotation for tick labels when rotating to condense labels.
      Note: Rotation doesn't occur until necessary.
      Note: Only applicable to horizontal scales. *)

  method minRotation : int Js.prop
  (** Minimum rotation for tick labels.
      Note: Only applicable to horizontal scales. *)

  method mirror : bool Js.prop
  (** Flips tick labels around axis, displaying the labels inside the chart
      instead of outside. Note: Only applicable to vertical scales. *)

  method padding : int Js.prop
  (** Padding between the tick label and the axis. When set on a vertical axis,
      this applies in the horizontal (X) direction. When set on a horizontal
      axis, this applies in the vertical (Y) direction. *)
end

class type ['a] cartesianAxis = object

  method _type : Axis_type.t Js.optdef Js.prop
  (** Type of scale being employed.
      Custom scales can be created and registered with a string key.
      This allows changing the type of an axis for a chart. *)

  method position : Position.t Js.prop
  (** Position of the axis in the chart.
      Possible values are: 'top', 'left', 'bottom', 'right' *)

  method offset : bool Js.t Js.prop
  (** If [true], extra space is added to the both edges and the axis
      is scaled to fit into the chart area. This is set to true for a
      category scale in a bar chart by default. *)

  method id : Js.js_string Js.t Js.prop
  (** The ID is used to link datasets and scale axes together. *)

  method gridLines : gridLines Js.t Js.prop
  (** Grid line configuration. *)

  method scaleLabel : scaleLabel Js.t Js.prop
  (** Scale title configuration. *)

  method ticks : (#cartesianTicks as 'a) Js.t Js.prop
  (** Tick configuration. *)

end

(** {3 Category axis} *)

class type categoryTicks = object
  inherit cartesianTicks

  method labels : Js.js_string Js.t Js.prop
  (** An array of labels to display. *)

  method min : Js.js_string Js.t Js.optdef_prop
  (** The minimum item to display. *)

  method max : Js.js_string Js.t Js.optdef_prop
  (** The maximum item to display. *)
end

and categoryAxis = [categoryTicks] cartesianAxis

(** {3 Linear axis} *)

class type linearTicks = object
  inherit cartesianTicks

  method beginAtZero : bool Js.t Js.optdef_prop
  (** If [true], scale will include 0 if it is not already included. *)

  method min : float Js.optdef_prop
  (** User defined minimum number for the scale,
      overrides minimum value from data. *)

  method max : float Js.optdef_prop
  (** User defined maximum number for the scale,
      overrides maximum value from data. *)

  method maxTicksLimit : int Js.prop
  (** Maximum number of ticks and gridlines to show. *)

  method precision : int Js.optdef_prop
  (** If defined and stepSize is not specified,
      the step size will be rounded to this many decimal places. *)

  method stepSize : int Js.optdef_prop
  (** User defined fixed step size for the scale. *)

  method suggestedMax : float Js.optdef_prop
  (** Adjustment used when calculating the maximum data value. *)

  method suggestedMin : float Js.optdef_prop
  (** Adjustment used when calculating the minimum data value. *)
end

and linearAxis = [linearTicks] cartesianAxis

(** {3 Logarithmic axis} *)

class type logarithmicTicks = object
  inherit cartesianTicks

  method min : float Js.optdef_prop
  (** User defined minimum number for the scale,
      overrides minimum value from data. *)

  method max : float Js.optdef_prop
  (** User defined maximum number for the scale,
      overrides maximum value from data. *)
end

and logarithmicAxis = [logarithmicTicks] cartesianAxis

(** {3 Time axis} *)

(** The following display formats are used to configure
    how different time units are formed into strings for
    the axis tick marks. *)
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
  (** How ticks are generated.
      [auto]: generates "optimal" ticks based on scale size and time options
      [data]: generates ticks from data (including labels from data objects)
      [labels]: generates ticks from user given data.labels values ONLY *)
end

and timeOptions = object
  method displayFormats : timeDisplayFormats Js.t Js.optdef_prop
  (** Sets how different time units are displayed. *)

  method isoWeekday : bool Js.t Js.prop
  (** If [true] and the unit is set to 'week', then the first day
      of the week will be Monday. Otherwise, it will be Sunday. *)

  method max : Time.t Js.optdef_prop
  (** If defined, this will override the data maximum *)

  method min : Time.t Js.optdef_prop
  (** If defined, this will override the data minimum *)

  method _parser : unit Js.optdef_prop (* FIXME *)
  (** Custom parser for dates. *)

  method round : Time_unit.t Or_false.t Js.t Js.prop
  (** If defined, dates will be rounded to the start of this unit. *)

  method tooltipFormat : Js.js_string Js.t Js.optdef_prop
  (** The moment js format string to use for the tooltip. *)

  method unit : Time_unit.t Or_false.t Js.t Js.prop
  (** If defined, will force the unit to be a certain type. *)

  method stepSize : int Js.prop
  (** The number of units between grid lines. *)

  method minUnit : Time_unit.t Js.prop
  (** The minimum display format to be used for a time unit. *)
end

and timeAxis = object
  inherit [timeTicks] cartesianAxis

  method time : timeOptions Js.t Js.prop

  method distribution : Time_distribution.t Js.prop
  (** The distribution property controls the data distribution along the scale:
      [linear]: data are spread according to their time (distances can vary)
      [series]: data are spread at the same distance from each other *)

  method bounds : Time_bounds.t Js.prop
  (** The bounds property controls the scale boundary strategy
      (bypassed by [min]/[max] time options).
      [data]: makes sure data are fully visible, labels outside are removed
      [ticks]: makes sure ticks are fully visible, data outside are truncated *)
end

class type scales = object
  method xAxes : 'a Js.t Js.js_array Js.t Js.optdef_prop
  method yAxes : 'a Js.t Js.js_array Js.t Js.optdef_prop
end

(** The option context is used to give contextual information when resolving
    options and currently only applies to scriptable options.
    Note: Since the context can represent different types of entities
    (dataset, data, etc.), some properties may be undefined so be sure to test
    any context property before using it.
*)
class type ['chart] optionContext = object
  method chart : 'chart Js.t Js.optdef Js.readonly_prop
  (** The associated chart. *)

  method dataIndex : int Js.optdef Js.readonly_prop
  (** Index of the current data. *)

  method dataset : dataset Js.t Js.optdef Js.readonly_prop
  (** Dataset at index datasetIndex. *)

  method datasetIndex : int Js.optdef Js.readonly_prop
  (** Index of the current dataset. *)
end

(** {1 Chart configuration} *)

and ['chart] animationItem = object
  method chart : 'chart Js.t Js.prop
  (** Chart object. *)

  method currentStep : float Js.prop
  (** Current Animation frame number. *)

  method numSteps : float Js.prop
  (** Number of animation frames. *)

  method render : 'chart Js.t -> 'chart animationItem Js.t -> unit Js.meth
  (** Function that renders the chart. *)

  method onAnimationProgress : ('chart animationItem Js.t -> unit) Js.callback Js.prop

  method onAnimationComplete : ('chart animationItem Js.t -> unit) Js.callback Js.prop
end

and ['chart] animation = object

  method duration : int Js.prop
  (** The number of milliseconds an animation takes. *)

  method easing : Easing.t Js.prop
  (** Easing function to use. *)

  method onProgress : ('chart animationItem Js.t -> unit) Js.callback Js.opt Js.prop
  (** Callback called on each step of an animation. *)

  method onComplete : ('chart animationItem Js.t -> unit) Js.callback Js.opt Js.prop
  (** Callback called at the end of an animation. *)

end

and layout = object
  method padding : Padding.t Js.prop
  (** The padding to add inside the chart. *)
end

and legendItem = object
  method text : Js.js_string Js.t Js.prop
  (** Label that will be displayed. *)

  method fillStyle : Color.t Js.prop
  (** Fill style of the legend box. *)

  method hidden : bool Js.t Js.prop
  (** If true, this item represents a hidden dataset.
      Label will be rendered with a strike-through effect. *)

  method lineCap : Line_cap.t Js.prop
  (** For box border. *)

  method lineDash : line_dash Js.prop
  (** For box border. *)

  method lineDashOffset : line_dash_offset Js.prop
  (** For box border. *)

  method lineJoin : Line_join.t Js.prop
  (** For box border. *)

  method lineWidth : int Js.prop
  (** Width of box border. *)

  method strokeStyle : Color.t Js.prop
  (** Stroke style of the legend box. *)

  method pointStyle : Js.js_string Js.t Js.prop
  (** Point style of the legend box (only used if usePointStyle is true) *)

  method datasetIndex : int Js.prop
end

and ['chart] legendLabels = object

  method boxWidth : int Js.prop
  (** Width of coloured box. *)

  method fontSize : int Js.prop
  (** Font size of text. *)

  method fontStyle : Js.js_string Js.prop
  (** Font style of text. *)

  method fontColor : Color.t Js.prop
  (** Color of text. *)

  method fontFamily : Js.js_string Js.prop
  (** Font family of legend text. *)

  method padding : int Js.prop
  (** Padding between rows of colored boxes. *)

  method generateLabels : ('chart Js.t -> legendItem Js.t Js.js_array Js.t)
      Js.callback Js.prop
  (** Generates legend items for each thing in the legend.
      Default implementation returns the text + styling for the color box. *)

  method filter : (legendItem Js.t -> data Js.t -> bool Js.t) Js.callback Js.prop
  (** Filters legend items out of the legend. Receives 2 parameters,
      a Legend Item and the chart data. *)

  method usePointStyle : bool Js.t Js.prop
  (** Label style will match corresponding point style
      (size is based on fontSize, boxWidth is not used in this case). *)
end

and ['chart] legend = object
  method display : bool Js.t Js.prop
  (** Is the legend shown. *)

  method position : Position.t Js.prop
  (** Position of the legend. *)

  method fullWidth : bool Js.t Js.prop
  (** Marks that this box should take the full width of the canvas
      (pushing down other boxes). This is unlikely to need to be changed
      in day-to-day use. *)

  method onClick :
    (Dom_html.event Js.t
     -> legendItem Js.t
     -> unit) Js.callback Js.prop
  (** A callback that is called when a click event is
      registered on a label item *)

  method onHover :
    (Dom_html.event Js.t
     -> legendItem Js.t
     -> unit) Js.callback Js.prop
  (** A callback that is called when a 'mousemove' event is
      registered on top of a label item *)

  method onLeave :
    (Dom_html.event Js.t
     -> legendItem Js.t
     -> unit) Js.callback Js.prop

  method reverse : bool Js.t Js.prop
  (** Legend will show datasets in reverse order. *)

  method labels : 'chart legendLabels Js.t Js.prop
  (** Legend label configuration. *)
end

and title = object
  method display : bool Js.t Js.prop
  (** Is the title shown. *)

  method position : Position.t Js.prop
  (** Position of title. *)

  method fontSize : int Js.optdef Js.prop
  (** Font size. *)

  method fontFamily : Js.js_string Js.t Js.prop
  (** Font family for the title text. *)

  method fontColor : Js.js_string Js.prop
  (** Font color. *)

  method fontStyle : Js.js_string Js.prop
  (** Font style. *)

  method padding : int Js.prop
  (** Number of pixels to add above and below the title text. *)

  method lineHeight : Line_height.t Js.prop
  (** Height of an individual line of text. *)

  method text : Js.js_string Js.t Indexable.t Js.prop
  (** Title text to display. If specified as an array,
      text is rendered on multiple lines. *)
end

and tooltipItem = object
  method label : Js.js_string Js.t Js.readonly_prop
  (** Label for the tooltip. *)

  method value : Js.js_string Js.t Js.readonly_prop
  (** Value for the tooltip. *)

  method datasetIndex : int Js.readonly_prop
  (** Index of the dataset the item comes from. *)

  method index : int Js.readonly_prop
  (** Index of this data item in the dataset. *)

  method x : float Js.readonly_prop
  (** X position of matching point. *)

  method y : float Js.readonly_prop
  (** Y position of matching point. *)
end

and tooltipBodyLines = object
  method before : Js.js_string Js.t Js.js_array Js.t Js.readonly_prop
  method lines : Js.js_string Js.t Js.js_array Js.t Js.readonly_prop
  method after : Js.js_string Js.t Js.js_array Js.t Js.readonly_prop
end

and tooltipModel = object

  method dataPoints : tooltipItem Js.t Js.js_array Js.t Js.readonly_prop
  (** The items that we are rendering in the tooltip. *)

  (** Positioning. *)

  method xPadding : int Js.readonly_prop
  method yPadding : int Js.readonly_prop
  method xAlign : Js.js_string Js.t Js.readonly_prop
  method yAlign : Js.js_string Js.t Js.readonly_prop

  (** X and Y readonly_properties are the top left of the tooltip. *)

  method x : float Js.readonly_prop
  method y : float Js.readonly_prop
  method width : float Js.readonly_prop
  method height : float Js.readonly_prop

  (** Where the tooltip points to. *)
  method caretX : int Js.readonly_prop
  method caretY : int Js.readonly_prop

  (** Body.
      The body lines that need to be rendered.
      Each object contains 3 parameters.
      [before] - lines of text before the line with the color square
      [lines] - lines of text to render as the main item with color square
      [after] - lines of text to render after the main lines. *)

  method body : tooltipBodyLines Js.t Js.readonly_prop
  method beforeBody : Js.js_string Js.t Js.js_array Js.t Js.readonly_prop
  method afterBody : Js.js_string Js.t Js.js_array Js.t Js.readonly_prop
  method bodyFontColor : Color.t Js.readonly_prop
  method __bodyFontFamily : Js.js_string Js.t Js.readonly_prop
  method __bodyFontStyle : Js.js_string Js.t Js.readonly_prop
  method __bodyAlign : Js.js_string Js.t Js.readonly_prop
  method bodyFontSize : int Js.readonly_prop
  method bodySpacing : int Js.readonly_prop

  (** Title. Lines of text that form the title. *)

  method title : Js.js_string Js.t Indexable.t Js.readonly_prop
  method titleFontColor : Color.t Js.readonly_prop
  method __titleFontFamily : Js.js_string Js.t Js.readonly_prop
  method __titleFontStyle : Js.js_string Js.t Js.readonly_prop
  method titleFontSize : int Js.readonly_prop
  method __titleAlign : Js.js_string Js.t Js.readonly_prop
  method titleSpacing : int Js.readonly_prop
  method titleMarginBottom : int Js.readonly_prop

  (** Footer. Lines of text that form the footer. *)

  method footer : Js.js_string Js.t Indexable.t Js.readonly_prop
  method footerFontColor : Color.t Js.readonly_prop
  method __footerFontFamily : Js.js_string Js.t Js.readonly_prop
  method __footerFontStyle : Js.js_string Js.t Js.readonly_prop
  method footerFontSize : int Js.readonly_prop
  method __footerAlign : Js.js_string Js.t Js.readonly_prop
  method footerSpacing : int Js.readonly_prop
  method footerMarginTop : int Js.readonly_prop

  (** Appearance. *)

  method caretSize : int Js.readonly_prop
  method caretPadding : int Js.readonly_prop
  method cornerRadius : int Js.readonly_prop
  method backgroundColor : Color.t Js.readonly_prop

  method labelColors : Color.t Js.js_array Js.t Js.readonly_prop
  (** Colors to render for each item in body. This is the color of the
      squares in the tooltip. *)

  method labelTextColors : Color.t Js.js_array Js.t Js.readonly_prop

  method opacity : float Js.readonly_prop
  (** Zero opacity is a hidden tooltip. *)

  method legendColorBackground : Color.t Js.readonly_prop
  method displayColors : bool Js.t Js.readonly_prop
  method borderColor : Color.t Js.readonly_prop
  method borderWidth : int Js.readonly_prop

end

and ['chart] tooltipCallbacks = object

  method beforeTitle :
    ('chart tooltip Js.t,
     tooltipItem Js.js_array Js.t,
     data Js.t) tooltip_cb Js.prop
  (** Returns the text to render before the title. *)

  method title :
    ('chart tooltip Js.t,
     tooltipItem Js.js_array Js.t,
     data Js.t) tooltip_cb Js.prop
  (** Returns the text to render as the title of the tooltip. *)

  method afterTitle :
    ('chart tooltip Js.t,
     tooltipItem Js.js_array Js.t,
     data Js.t) tooltip_cb Js.prop
  (** Returns the text to render after the title. *)

  method beforeBody :
    ('chart tooltip Js.t,
     tooltipItem Js.js_array Js.t,
     data Js.t) tooltip_cb Js.prop
  (** Returns the text to render before the body section. *)

  method beforeLabel :
    ('chart tooltip Js.t,
     tooltipItem Js.t,
     data Js.t) tooltip_cb Js.prop
  (** Returns the text to render before an individual label.
      This will be called for each item in the tooltip. *)

  method label :
    ('chart tooltip Js.t,
     tooltipItem Js.t,
     data Js.t) tooltip_cb Js.prop
  (** Returns the text to render for an individual item in the tooltip. *)

  method labelColor :
    ('chart tooltip Js.t,
     tooltipItem Js.t,
     'chart Js.t) tooltip_cb Js.prop
  (** Returns the colors to render for the tooltip item. *)

  method labelTextColor :
    ('chart tooltip Js.t,
     tooltipItem Js.t,
     'chart Js.t) tooltip_cb Js.prop
  (** Returns the colors for the text of the label for the tooltip item. *)

  method afterLabel :
    ('chart tooltip Js.t,
     tooltipItem Js.t,
     data Js.t) tooltip_cb Js.prop
  (** Returns text to render after an individual label. *)

  method afterBody :
    ('chart tooltip Js.t,
     tooltipItem Js.t Js.js_array Js.t,
     data Js.t) tooltip_cb Js.prop
  (** Returns text to render after the body section. *)

  method beforeFooter :
    ('chart tooltip Js.t,
     tooltipItem Js.js_array Js.t,
     data Js.t) tooltip_cb Js.prop
  (** Returns text to render before the footer section. *)

  method footer :
    ('chart tooltip Js.t,
     tooltipItem Js.js_array Js.t,
     data Js.t) tooltip_cb Js.prop
  (** Returns text to render as the footer of the tooltip. *)

  method afterFooter :
    ('chart tooltip Js.t,
     tooltipItem Js.js_array Js.t,
     data Js.t) tooltip_cb Js.prop
  (** Text to render after the footer section. *)

end

and ['chart] tooltip = object
  method enabled : bool Js.t Js.prop
  (** Are on-canvas tooltips enabled. *)

  method custom : (tooltipModel Js.t -> unit) Js.callback Js.opt Js.prop
  (** Custom tooltip callback. *)

  method mode : Interaction_mode.t Js.prop
  (** Sets which elements appear in the tooltip. *)

  method intersect : bool Js.t Js.prop
  (** If true, the tooltip mode applies only when the mouse position
      intersects with an element. If false, the mode will be applied
      at all times. *)

  method position : Tooltip_position.t Js.prop
  (** The mode for positioning the tooltip. *)

  method callbacks : 'chart tooltipCallbacks Js.t Js.optdef Js.prop
  (** Callbacks. *)

  method itemSort : (tooltipItem Js.t
                     -> tooltipItem Js.t
                     -> data Js.t (* FIXME *)
                     -> int) Js.callback Js.optdef Js.prop
  (** Sort tooltip items. *)

  method filter : (tooltipItem Js.t
                   -> data Js.t
                   -> bool Js.t) Js.callback Js.optdef Js.prop
  (** Filter tooltip items. *)

  method backgroundColor : Color.t Js.prop
  (** Background color of the tooltip. *)

  method titleFontFamily : Js.js_string Js.t Js.prop
  (** Title font. *)

  method titleFontSize : int Js.prop
  (** Title font size. *)

  method titleFontStyle : Js.js_string Js.t Js.prop
  (** Title font style *)

  method titleFontColor : Color.t Js.prop
  (** Title font color *)

  method titleSpacing : int Js.prop
  (** Spacing to add to top and bottom of each title line. *)

  method titleMarginBottom : int Js.prop
  (** Margin to add on bottom of title section. *)

  method bodyFontFamily : Js.js_string Js.t Js.prop
  (** Body line font. *)

  method bodyFontSize : int Js.prop
  (** Body font size. *)

  method bodyFontStyle : Js.js_string Js.t Js.prop
  (** Body font style. *)

  method bodyFontColor : Color.t Js.prop
  (** Body font color. *)

  method bodySpacing : int Js.prop
  (** Spacing to add to top and bottom of each tooltip item. *)

  method footerFontFamily : Js.js_string Js.t Js.prop
  (** Footer font. *)

  method footerFontSize : int Js.prop
  (** Footer font size. *)

  method footerFontStyle : Js.js_string Js.t Js.prop
  (** Footer font style. *)

  method footerFontColor : Color.t Js.prop
  (** Footer font color. *)

  method footerSpacing : int Js.prop
  (** Spacing to add to top and bottom of each footer line. *)

  method footerMarginTop : int Js.prop
  (** Margin to add before drawing the footer. *)

  method xPadding : int Js.prop
  (** Padding to add on left and right of tooltip. *)

  method yPadding : int Js.prop
  (** Padding to add on top and bottom of tooltip. *)

  method caretPadding : int Js.prop
  (** Extra distance to move the end of the tooltip arrow
      away from the tooltip point. *)

  method caretSize : int Js.prop
  (** Size, in px, of the tooltip arrow. *)

  method cornerRadius : int Js.prop
  (** Radius of tooltip corner curves. *)

  method multyKeyBackground : Color.t Js.prop
  (** Color to draw behind the colored boxes when multiple
      items are in the tooltip. *)

  method displayColors : bool Js.t Js.prop
  (** If [true], color boxes are shown in the tooltip. *)

  method borderColor : Color.t Js.prop
  (** Color of the border. *)

  method borderWidth : int Js.prop
  (** Size of the border. *)
end

and hover = object

  method mode : Interaction_mode.t Js.prop
  (** Sets which elements appear in the tooltip. *)

  method intersect : bool Js.t Js.prop
  (** If true, the hover mode only applies when the mouse
      position intersects an item on the chart. *)

  method axis : Hover_axis.t Js.prop
  (** Defines which directions are used in calculating distances.
      Defaults to [x] for index mode and [xy] in [dataset] and [nearest]
      modes. *)

  method animationDuration : int Js.prop
  (** Duration in milliseconds it takes to animate hover style changes. *)

end

and pointElement = object

  method radius : int Js.prop
  (** Point radius. *)

  method pointStyle : Point_style.t Js.prop
  (** Point style. *)

  method rotation : int Js.prop
  (** Point rotation (in degrees). *)

  method backgroundColor : Color.t Js.prop
  (** Point fill color. *)

  method borderWidth : int Js.prop
  (** Point stroke width. *)

  method borderColor : Color.t Js.prop
  (** Point stroke color. *)

  method hitRadius : int Js.prop
  (** Extra radius added to point radius for hit detection. *)

  method hoverRadius : int Js.prop
  (** Point radius when hovered. *)

  method hoverBorderWidth : int Js.prop
  (** Stroke width when hovered. *)

end

and lineElement = object

  method tension : float Js.prop
  (** Bézier curve tension (0 for no Bézier curves). *)

  method backgroundColor : Color.t Js.prop
  (** Line fill color. *)

  method borderWidth : int Js.prop
  (** Line stroke width. *)

  method borderColor : Color.t Js.prop
  (** Line stroke color. *)

  method borderCapStyle : Line_cap.t Js.prop
  (** Line cap style. *)

  method borderDash : line_dash Js.prop
  (** Line dash. *)

  method borderDashOffset : line_dash_offset Js.prop
  (** Line dash offset. *)

  method borderJoinStyle : Line_join.t Js.prop
  (** Line join style. *)

  method capBezierPoints : bool Js.t Js.prop
  (** [true] to keep Bézier control inside the chart,
      [false] for no restriction.*)

  method fill : Fill.t Js.t Js.prop
  (** Fill location. *)

  method stepped : bool Js.t Js.prop
  (** [true] to show the line as a stepped line (tension will be ignored). *)

end

and rectangleElement = object

  method backgroundColor : Js.js_string Js.prop
  (** Bar fill color. *)

  method borderWidth : int Js.prop
  (** Bar stroke width. *)

  method borderColor : Color.t Js.prop
  (** Bar stroke color. *)

  method borderSkipped : Position.t Js.prop
  (** Skipped (excluded) border: 'bottom', 'left', 'top' or 'right'. *)

end

and arcElement = object

  method backgroundColor : Color.t Js.prop
  (** Arc fill color. *)

  method borderAlign : Js.js_string Js.t Js.prop
  (** Arc stroke alignment. *)

  method borderColor : Color.t Js.prop
  (** Arc stroke color. *)

  method borderWidth : int Js.prop
  (** Arc stroke width. *)

end

and elements = object

  method point : pointElement Js.t Js.prop
  (** Point elements are used to represent the points
      in a line chart or a bubble chart. *)

  method line : lineElement Js.t Js.prop
  (** Line elements are used to represent the line in a line chart. *)

  method rectangle : rectangleElement Js.t Js.prop
  (** Rectangle elements are used to represent the bars in a bar chart. *)

  method arc : arcElement Js.t Js.prop
  (** Arcs are used in the polar area, doughnut and pie charts. *)

end

and chartSize = object
  method width : int Js.readonly_prop

  method height : int Js.readonly_prop
end

(** The configuration is used to change how the chart behaves.
    There are properties to control styling, fonts, the legend, etc. *)
and ['chart] chartOptions = object

  method scales : scales Js.t Js.prop

  method animation : 'chart animation Js.t Js.prop
  (** Chart.js animates charts out of the box.
      A number of options are provided to configure how the animation
      looks and how long it takes. *)

  method layout : layout Js.t Js.prop
  (** Layout configurations. *)

  method legend : 'chart legend Js.t Js.prop
  (** The chart legend displays data about the datasets
      that are appearing on the chart. *)

  method title : title Js.t Js.prop
  (** The chart title defines text to draw at the top of the chart. *)

  method tooltip : 'chart tooltip Js.t Js.prop

  method elements : elements Js.t Js.prop
  (** While chart types provide settings to configure the styling
      of each dataset, you sometimes want to style all datasets the same way.
      A common example would be to stroke all of the bars in a bar chart with
      the same colour but change the fill per dataset.
      Options can be configured for four different types of elements: arc, lines,
      points, and rectangles. When set, these options apply to all objects
      of that type unless specifically overridden by the configuration attached
      to a dataset. *)

  method plugins : 'a Js.t Js.prop
  (** Plugins are the most efficient way to customize or change the default
      behavior of a chart. This option allows to define plugins directly in
      the chart [plugins] config (a.k.a. inline plugins). *)

  method legendCallback : ('chart Js.t -> Js.js_string Js.t) Js.callback Js.optdef_prop
  (** Sometimes you need a very complex legend. In these cases, it makes sense
      to generate an HTML legend. Charts provide a generateLegend() method on their
      prototype that returns an HTML string for the legend.
      NOTE [legendCallback] is not called automatically and you must call
      [generateLegend] yourself in code when creating a legend using this method. *)

  method responsive : bool Js.t Js.prop
  (** Resizes the chart canvas when its container does. *)

  method responsiveAnimationDuration : int Js.prop
  (** Duration in milliseconds it takes to animate
      to new size after a resize event. *)

  method maintainAspectRatio : bool Js.t Js.prop
  (** Maintain the original canvas aspect ratio (width / height) when resizing. *)

  method aspectRatio : float Js.prop
  (** Canvas aspect ratio (i.e. width / height, a value of 1
      representing a square canvas). Note that this option is
      ignored if the height is explicitly defined either as
      attribute or via the style. *)

  method onResize :
    ('chart Js.t
     -> chartSize Js.t
     -> unit) Js.callback Js.opt Js.prop
  (** Called when a resize occurs. Gets passed two arguments:
      the chart instance and the new size. *)

  method devicePixelRatio : float Js.prop
  (** Override the window's default devicePixelRatio. *)

  method events : Js.js_string Js.t Js.js_array Js.t Js.prop
  (** The events option defines the browser events that
      the chart should listen to for tooltips and hovering. *)

  method onHover :
    ('chart Js.t, Dom_html.event Js.t
     -> 'a Js.t Js.js_array Js.t
     -> unit)
      Js.meth_callback Js.opt Js.prop
  (** Called when any of the events fire.
      Called in the context of the chart and passed the event
      and an array of active elements (bars, points, etc). *)

  method onClick :
    ('chart Js.t, Dom_html.event Js.t
     -> 'a Js.t Js.js_array Js.t
     -> unit)
      Js.meth_callback Js.opt Js.prop
  (** Called if the event is of type 'mouseup' or 'click'.
      Called in the context of the chart and passed the event
      and an array of active elements. *)

end

and dataset = object

  method _type : 'a Chart_type.t Js.optdef Js.prop

end

and data = object

  method datasets : dataset Js.t Js.js_array Js.t Js.prop

  method labels : Js.js_string Js.t Js.js_array Js.t Js.prop

  method xLabels : Js.js_string Js.t Js.js_array Js.t Js.optdef Js.prop

  method yLabels : Js.js_string Js.t Js.js_array Js.t Js.optdef Js.prop

end

and ['a] chartConfig = object
  method data : data Js.t Js.prop

  method options : 'a Js.t Js.prop

  method _type : 'a Chart_type.t Js.prop
end

and updateConfig = object
  method duration : int Js.optdef_prop

  method lazy_ : bool Js.t Js.optdef_prop

  method easing : Easing.t Js.optdef_prop
end

and ['a] chart = object
  constraint 'a = 'chart #chartOptions

  method height : int Js.readonly_prop
  method width : int Js.readonly_prop
  method offsetX : int Js.readonly_prop
  method offsetY : int Js.readonly_prop
  method borderWidth : int Js.readonly_prop
  method animating : bool Js.t Js.readonly_prop
  method aspectRatio : float Js.readonly_prop
  method canvas : Dom_html.canvasElement Js.t Js.readonly_prop
  method ctx : Dom_html.canvasRenderingContext2D Js.t Js.readonly_prop
  method data : data Js.t Js.prop
  method options : 'a Js.t
  method config : 'a chartConfig Js.t Js.prop

  method destroy : unit Js.meth

  method update : unit Js.meth

  method update_withConfig : updateConfig Js.t -> unit Js.meth

  method reset : unit Js.meth

  method render : unit Js.meth

  method render_withConfig : updateConfig Js.t -> unit Js.meth

  method stop : 'options chart Js.t Js.meth

  method resize : 'options chart Js.t Js.meth

  method clear : 'options chart Js.t Js.meth

  method toBase64Image : Js.js_string Js.t Js.meth

  method generateLegend : Js.js_string Js.t Js.meth

end

(** {1 Charts} *)

(** {2 Line Chart} *)

class type lineOptions = object
  inherit [lineChart] chartOptions

  method showLines : bool Js.t Js.prop
  (** If [false], the lines between points are not drawn. *)

  method spanGaps : bool Js.t Js.prop
  (** If [false], NaN data causes a break in the line. *)
end

and lineDataset = object

  inherit dataset

  (** {2 General} *)

  method label : Js.js_string Js.t Js.prop
  (** The label for the dataset which appears in the legend and tooltips. *)

  method xAxisID : Js.js_string Js.t Js.prop
  (** The ID of the x axis to plot this dataset on. *)

  method yAxisID : Js.js_string Js.t Js.prop
  (** The ID of the y axis to plot this dataset on. *)

  (** {2 Point styling} *)

  method pointBackgroundColor : Color.t Scriptable.t Js.t Js.prop
  (** The fill color for points. *)

  method pointBorderColor : Color.t Scriptable.t Js.t Js.prop
  (** The border color for points. *)

  method pointBorderWidth : int Scriptable.t Js.t Js.prop
  (** The width of the point border in pixels. *)

  method pointHitRadius : int Scriptable.t Js.t Js.prop
  (** The pixel size of the non-displayed point that reacts to mouse events. *)

  method pointRadius : int Scriptable.t Js.t Js.prop
  (** The radius of the point shape. If set to 0, the point is not rendered. *)

  method pointRotation : int Scriptable.t Js.t Js.prop
  (** The rotation of the point in degrees. *)

  method pointStyle : Point_style.t Js.prop
  (** Style of the point. *)

  (** {2 Line styling} *)

  method backgroundColor : Color.t Js.prop
  (** The line fill color. *)

  method borderCapStyle : Line_cap.t Js.prop
  (** Cap style of the line. *)

  method borderColor : Color.t Js.prop
  (** The line color. *)

  method borderDash : line_dash Js.prop
  (** Length and spacing of dashes. *)

  method borderDashOffset : line_dash_offset Js.prop
  (** Offset for line dashes. *)

  method borderJoinStyle : Line_join.t Js.prop
  (** Line joint style. *)

  method borderWidth : int Js.prop
  (** The line width (in pixels). *)

  method fill : Line_fill.t Js.t Js.prop
  (** How to fill the area under the line. *)

  method lineTension : float Js.prop
  (** Bezier curve tension of the line. Set to 0 to draw straightlines.
      This option is ignored if monotone cubic interpolation is used. *)

  method showLine : bool Js.t Js.optdef Js.prop
  (** If [false], the line is not drawn for this dataset. *)

  method spanGaps : bool Js.t Js.optdef Js.prop
  (** If [true], lines will be drawn between points with no or null data.
      If [false], points with NaN data will create a break in the line. *)

  (** {2 Interactions} *)

  method pointHoverBackgroundColor : Color.t Scriptable.t Js.t Js.optdef Js.prop
  (** Point background color when hovered. *)

  method pointHoverBorderColor : Color.t Scriptable.t Js.t Js.optdef Js.prop
  (** Point border color when hovered. *)

  method pointHoverBorderWidth : int Scriptable.t Js.t Js.optdef Js.prop
  (** Border width of point when hovered. *)

  method pointHoverRadius : int Scriptable.t Js.t Js.optdef Js.prop
  (** The radius of the point when hovered. *)

  (** {2 Cubic Interpolation Mode} *)

  method cubicInterpolationMode : Interpolation_mode.t Js.prop
  (** The [default] and [monotone] interpolation modes are supported.
      The [default] algorithm uses a custom weighted cubic interpolation,
      which produces pleasant curves for all types of datasets.
      The [monotone] algorithm is more suited to [y = f(x)] datasets : it preserves
      monotonicity (or piecewise monotonicity) of the dataset being interpolated,
      and ensures local extremums (if any) stay at input data points.
      If left untouched (undefined), the global
      [options.elements.line.cubicInterpolationMode] property is used. *)

  (** {2 Stepped Line} *)

  method steppedLine : Stepped_line.t Js.t Js.prop
  (** The following values are supported for steppedLine.
      [false]: No Step Interpolation (default)
      [true]: Step-before Interpolation (eq. 'before')
      ['before']: Step-before Interpolation
      ['after']: Step-after Interpolation
      ['middle']: Step-middle Interpolation
      If the [steppedLine] value is set to anything other than [false],
      [lineTension] will be ignored.*)

end

and lineChart = object
  inherit [lineOptions] chart
end

(** {2 Bar Chart} *)

class type barScale = object

  method barPercentage : float Js.prop
  (** Percent (0-1) of the available width each bar should be within
      the category width. 1.0 will take the whole category width and
      put the bars right next to each other. *)

  method categoryPercentage : float Js.prop
  (** Percent (0-1) of the available width each category should be within
      the sample width. *)

  method barThickness : float Js.optdef Js.prop (* FIXME *)
  (** Manually set width of each bar in pixels. If set to 'flex',
      it computes "optimal" sample widths that globally arrange bars side by side.
      If not set (default), bars are equally sized based on the smallest interval. *)

  method maxBarThickness : float Js.optdef Js.prop
  (** Set this to ensure that bars are not sized thicker than this. *)

  method minBarLength : float Js.optdef Js.prop
  (** Set this to ensure that bars have a minimum length in pixels. *)

end

and barOptions = object
  inherit [barChart] chartOptions
end

and barDataset = object
  inherit dataset

  (** {2 General} *)

  method label : Js.js_string Js.t Js.prop
  (** The label for the dataset which appears in the legend and tooltips. *)

  method xAxisID : Js.js_string Js.t Js.prop
  (** The ID of the x axis to plot this dataset on. *)

  method yAxisID : Js.js_string Js.t Js.prop
  (** The ID of the y axis to plot this dataset on. *)

  (** {2 Styling} *)

  method backgroundColor : Color.t Scriptable.t Js.t Js.prop
  (** The bar background color. *)

  method borderColor : Color.t Scriptable.t Js.t Js.prop
  (** The bar border color. *)

  method borderSkipped : Position.t Or_false.t Js.t Scriptable.t Js.t Js.prop
  (** The edge to skip when drawing bar.
      This setting is used to avoid drawing the bar stroke at the base of the fill.
      In general, this does not need to be changed except when creating chart types
      that derive from a bar chart.
      Note: for negative bars in vertical chart, top and bottom are flipped.
      Same goes for left and right in horizontal chart.
      Options are:
      ['bottom'],
      ['left'],
      ['top'],
      ['right'],
      [false] *)

  method borderWidth : Padding.t Js.t Or_false.t Js.t Scriptable.t Js.t Js.prop
  (** The bar border width (in pixels).
      If this value is a number, it is applied to all sides of the rectangle
      (left, top, right, bottom), except [borderSkipped]. If this value is
      an object, the [left] property defines the left border width. Similarly
      the [right], [top] and [bottom] properties can also be specified.
      Omitted borders and [borderSkipped] are skipped. *)

  (** {2 Interactions}
      All these values, if undefined, fallback to the associated
      [elements.rectangle.*] options. *)

  method hoverBackgroundColor : Color.t Indexable.t Js.t Js.optdef Js.prop
  (** The bar background color when hovered. *)

  method hoverBorderColor : Color.t Indexable.t Js.t Js.optdef Js.prop
  (** The bar border color when hovered. *)

  method hoverBorderWidth : Color.t Indexable.t Js.t Js.prop
  (** The bar border width when hovered (in pixels). *)

end

and barChart = object
  inherit [barOptions] chart
end

(** {1 Type Coercion} *)

module CoerceTo = struct

  let unsafe_coerce_chart typ (chart : 'a chart Js.t) =
    if chart##.config##._type##toLowerCase == Js.string typ
    then Js.some (Js.Unsafe.coerce chart)
    else Js.null

  let line c = unsafe_coerce_chart "line" c

  let bar c = unsafe_coerce_chart "bar" c

  let horizontal_bar c = unsafe_coerce_chart "horizontalBar" c

end

(** {1 Creating a Chart} *)

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

let make_update_config ?duration ?lazy_ ?easing () : updateConfig Js.t =
  let iter f = function None -> () | Some x -> f x in
  let (conf : updateConfig Js.t) = Js.Unsafe.obj [||] in
  iter (fun x -> conf##.duration := x) duration;
  iter (fun x -> conf##.lazy_ := Js.bool x) lazy_;
  iter (fun x -> conf##.easing := x) easing;
  conf
