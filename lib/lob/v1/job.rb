module Lob
  module V1
    class Job

      def initialize(resource)
        @resource = resource
      end

      def list(options={})
        Lob.submit(:get, job_url, options)["data"] || []
      end

      def find(job_id)
        Lob.submit :get, job_url(job_id)
      end

      def create(name, to, object1, options = {})
        options = { name: name, to: to, object1: object1 }.merge(options)

        if options[:to] && !options[:to].is_a?(String)
          options[:to] = @resource.format_address_params(options[:to])
        end

        if options[:from] && !options[:from].is_a?(String)
          options[:from] = @resource.format_address_params(options[:from])
        end

        Lob.submit :post, job_url, options
      end


      private

      def job_url(job_id = nil)
        @resource.construct_url("jobs", job_id)
      end

    end
  end
end
