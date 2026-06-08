# frozen_string_literal: true

module UI
  class VideoComponent < ApplicationComponent
    BASE = "h-auto w-full max-w-full rounded-md"

    # Add <source> elements via v.with_source(src:, type:)
    renders_many :sources, "UI::VideoComponent::SourceComponent"
    # Add <track> elements via v.with_track(src:, kind:, label:, srclang:)
    renders_many :tracks, "UI::VideoComponent::TrackComponent"

    # poster:      URL of the preview image shown before playback
    # controls:    show native browser controls (default: true)
    # autoplay:    start playing automatically — requires muted: true
    # muted:       mute the audio track
    # loop:        loop playback
    # preload:     :auto | :metadata (default) | :none
    # playsinline: play inline on iOS instead of fullscreen
    # width / height: explicit dimensions (prefer CSS or Aspect Ratio)
    def initialize(poster: nil, controls: true, autoplay: false, muted: false,
                   loop: false, preload: :metadata, playsinline: true,
                   width: nil, height: nil, **html_attrs)
      @poster      = poster
      @controls    = controls
      @autoplay    = autoplay
      @muted       = muted
      @loop        = loop
      @preload     = preload
      @playsinline = playsinline
      @width       = width
      @height      = height
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      attrs = { class: cn(BASE, @extra_class), preload: @preload }
      attrs[:poster]      = @poster   if @poster
      attrs[:controls]    = true      if @controls
      attrs[:autoplay]    = true      if @autoplay
      attrs[:muted]       = true      if @muted || @autoplay
      attrs[:loop]        = true      if @loop
      attrs[:playsinline] = true      if @playsinline
      attrs[:width]       = @width    if @width
      attrs[:height]      = @height   if @height

      content_tag(:video, **attrs, **@html_attrs) do
        sources.each { |s| concat s }
        tracks.each  { |t| concat t }
        concat content if content?
      end
    end

    # Represents a <source> element inside <video>.
    # v.with_source(src: "video.mp4", type: "video/mp4")
    class SourceComponent < ApplicationComponent
      def initialize(src:, type:, **html_attrs)
        @src  = src
        @type = type
        @html_attrs = html_attrs
      end

      def call
        tag.source(src: @src, type: @type, **@html_attrs)
      end
    end

    # Represents a <track> element (captions, subtitles, chapters).
    # v.with_track(src: "captions.vtt", kind: :subtitles, label: "English", srclang: "en")
    # kind: :subtitles | :captions | :descriptions | :chapters | :metadata
    class TrackComponent < ApplicationComponent
      KINDS = %i[subtitles captions descriptions chapters metadata].freeze

      def initialize(src:, kind: :subtitles, label: nil, srclang: nil, default: false, **html_attrs)
        @src     = src
        @kind    = KINDS.include?(kind.to_sym) ? kind.to_sym : :subtitles
        @label   = label
        @srclang = srclang
        @default = default
        @html_attrs = html_attrs
      end

      def call
        attrs = { src: @src, kind: @kind }
        attrs[:label]   = @label   if @label
        attrs[:srclang] = @srclang if @srclang
        attrs[:default] = true     if @default
        tag.track(**attrs, **@html_attrs)
      end
    end
  end
end
