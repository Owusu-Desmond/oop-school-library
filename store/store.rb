require 'json'

class Store
  def store_books(list)
    # convert class to hash
    hash = list.map do |item|
      obj = {
        title: item.title,
        author: item.author
      }
      obj[:rentals] = item.rentals.map do |rental|
        {
          # check if the data is a hash or a class
          date: rental.is_a?(Hash) ? rental['date'] : rental.date,
          person: {
            name: rental.is_a?(Hash) ? rental['person']['name'] : rental.person.name,
            id: rental.is_a?(Hash) ? rental['person']['id'] : rental.person.id,
            age: rental.is_a?(Hash) ? rental['person']['age'] : rental.person.age
          }
        }
      end
      obj # return obj
    end
    json = JSON.pretty_generate(hash)
    File.write('store/books.json', json)
  end

  def store_people(list)
    # convert class to hash
    hash = list.map do |item|
      obj = {
        id: item.id,
        name: item.name,
        age: item.age,
        classroom: item.is_a?(Teacher) ? '' : item.classroom,
        parent_permission: item.is_a?(Teacher) ? '' : item.parent_permission,
        specialization: item.is_a?(Teacher) ? item.specialization : ''
      }
      obj # return obj
    end
    json = JSON.pretty_generate(hash)
    File.write('store/people.json', json)
  end

  def store_rentals(list)
    # convert class to hash
    hash = list.map do |item|
      obj = {
        date: item.date,
        book: {
          title: item.book.title,
          author: item.book.author
        },
        person: item.person.id
      }
      obj # return obj
    end

    json = JSON.pretty_generate(hash)
    File.write('store/rentals.json', json)
  end
end
