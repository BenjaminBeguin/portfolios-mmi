class Api::V1::UserSerializer < ActiveModel::Serializer
    attributes  :id,
                :ville,
                :job,
                :fullname,
                :firstname,
                :lastname,
                :slug,
                :portfolio,

    def created_at
        object.created_at.in_time_zone.iso8601 if object.created_at
    end

    def updated_at
        object.updated_at.in_time_zone.iso8601 if object.created_at
    end
end
