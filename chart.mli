open Chartjs_types

[@@@js.stop]
type canvas = Dom_html.canvasElement Js.t
[@@@js.start]
[@@@js.implem
 type canvas = Dom_html.canvasElement Js.t
]
val canvas_to_js : canvas -> Ojs.t
  [@@js.custom let canvas_to_js (c : canvas) : Ojs.t =
     Obj.magic c
  ]
val canvas_of_js : Ojs.t -> canvas
  [@@js.custom let canvas_of_js (js : Ojs.t) : canvas =
     Obj.magic js
  ]

[@@@js.stop]
type context = Dom_html.canvasRenderingContext2D Js.t
[@@@js.start]
[@@@js.implem
 type context = Dom_html.canvasRenderingContext2D Js.t
]
val context_to_js : context -> Ojs.t
  [@@js.custom
   let context_to_js (c : context) : Ojs.t =
     Obj.magic c
  ]
val context_of_js : Ojs.t -> context
  [@@js.custom
   let context_of_js (js : Ojs.t) : context =
     Obj.magic js
  ]

type node =
  [ `Canvas of canvas
  | `Context of context
  | `Id of string
  ] [@js.union]

(** A config object can be provided with additional configuration
    for the update process. This is useful when update is manually
    called inside an event handler and some different animation is
    desired. *)
type api_config
val make_api_config :
  (** Time for the animation of the redraw in milliseconds. *)
  ?duration:int ->
  (** If true, the animation can be interrupted by other animations. *)
  ?lazy_:bool ->
  (** The animation easing function. *)
  ?easing:easing ->
  unit ->
  api_config [@@js.builder]

type t
val t_to_js : t -> Ojs.t
val t_of_js : Ojs.t -> t

val id : t -> int
val inner_radius : t -> int
val height : t -> int
val width : t -> int
val offset_x : t -> int
val offset_y : t -> int
val border_width : t -> int
val animating : t -> bool
val aspect_ratio : t -> float
val canvas : t -> canvas
val ctx : t -> context

val options : t -> Chartjs_options.t
val set_options : t -> Chartjs_options.t -> unit

(** ChartJS API *)
(** TODO add
    'get_element_at_event',
    'get_elements_at_event',
    'get_dataset_meta' *)

(** Use this to destroy any chart instances that are created.
    This will clean up any references stored to the chart object
    within Chart.js, along with any associated event listeners
    attached by Chart.js. This must be called before the canvas
    is reused for a new chart. *)
val destroy : t -> unit [@@js.call]
(** Triggers an update of the chart.
    This can be safely called after updating the data object.
    This will update all scales, legends, and then re-render the chart. *)
val update : t -> api_config option -> unit [@@js.call]
(** Reset the chart to it's state before the initial animation.
    A new animation can then be triggered using update. *)
val reset : t -> unit [@@js.call]
(** Triggers a redraw of all chart elements.
    Note, this does not update elements for new data.
    Use .update() in that case. *)
val render : t -> api_config option -> unit [@@js.call]
(** Use this to stop any current animation loop.
    This will pause the chart during any current animation frame.
    Call .render() to re-animate. *)
val stop : t -> t [@@js.call]
(** Use this to manually resize the canvas element.
    This is run each time the canvas container is resized,
    but you can call this method manually if you change the size of
    the canvas nodes container element. *)
val resize : t -> t [@@js.call]
(** Will clear the chart canvas. Used extensively internally between
    animation frames, but you might find it useful. *)
val clear : t -> t [@@js.call]
(** This returns a base 64 encoded string of the chart
    in it's current state. *)
val to_base64_image : t -> string [@@js.call]
(** Returns an HTML string of a legend for that chart.
    The legend is generated from the legendCallback in the options. *)
val generate_legend : t -> string [@@js.call]

type config
val make_config : ?data:Ojs.t ->
                  ?options:Chartjs_options.t ->
                  ?type_:string ->
                  unit ->
                  config [@@js.builder]

(** Create new chart instance *)
val new_chart : node -> config -> t [@@js.new "Chart"]
