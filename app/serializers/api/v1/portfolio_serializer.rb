class Api::V1::PortfolioSerializer < ActiveModel::Serializer
    attributes  :id,
                :url,
                :picture,
                :visite,
                :like,
                :user

    has_one :user

    def created_at
        object.created_at.in_time_zone.iso8601 if object.created_at
    end

    def updated_at
        object.updated_at.in_time_zone.iso8601 if object.created_at
    end
end
