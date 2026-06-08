# frozen_string_literal: true

module UI
  class AudioComponent < ApplicationComponent
    # Add <source> elements via a.with_source(src:, type:)
    renders_many :sources, "UI::AudioComponent::SourceComponent"

    # controls:    show native browser controls (default: true)
    # autoplay:    start playing automatically — requires muted: true in some browsers
    # muted:       mute the audio track
    # loop:        loop playback
    # preload:     :auto | :metadata (default) | :none
    def initialize(controls: true, autoplay: false, muted: false,
                   loop: false, preload: :metadata, **html_attrs)
      @controls = controls
      @autoplay = autoplay
      @muted    = muted
      @loop     = loop
      @preload  = preload
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      attrs = { preload: @preload, class: cn("w-full rounded-md", @extra_class) }
      attrs[:controls] = true if @controls
      attrs[:autoplay] = true if @autoplay
      attrs[:muted]    = true if @muted
      attrs[:loop]     = true if @loop

      content_tag(:audio, **attrs, **@html_attrs) do
        sources.each { |s| concat s }
        concat content if content?
      end
    end

    # Represents a <source> element inside <audio>.
    # a.with_source(src: "audio.mp3", type: "audio/mpeg")
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
  end
end
