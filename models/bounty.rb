require('pg') # load PostGres gem
require('pry-byebug') # load PostGres gem

class Bounty

  attr_accessor :name, :bounty, :danger_level, :cashed_in
  attr_reader :id

  def initialize(options)
    # USER creates name, bounty, danger_level, cashed_in params
    @name = options['name']
    @bounty = options['bounty'].to_i
    @danger_level = options['danger_level']
    @cashed_in = options['cashed_in']
    # ID created when added to DB
    @id = options['id'].to_i if options['id'] # add only if exists
  end

  def save()
    # define db and location
    db = PG.connect( {dbname: 'bounties', host: 'localhost'} )
    # define SQL command
    sql = "INSERT INTO bounty_list
          (name, bounty, danger_level, cashed_in)
          VALUES ($1, $2, $3, $4)
          RETURNING *"
    # prepare SQL statment
    db.prepare("save", sql)
    # define values to pass into SQL statement
    values = [@name, @bounty, @danger_level, @cashed_in]
    # execute statement with values, and assign DB id to @id,
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    # close DATABASE
    db.close()
  end

  def Bounty.all()
    # define db and location
    db = PG.connect( {dbname: 'bounties', host: 'localhost'} )
    # def SQL cmd
    sql = "SELECT * FROM bounty_list"
    bounties = db.exec(sql)
    db.close()
    return bounties.map{|bounty| Bounty.new(bounty)}
  end


  def update()
    # define db and location
    db = PG.connect( {dbname: 'bounties', host: 'localhost'} )
    # define SQL command
    sql = "UPDATE bounty_list
          SET (name, bounty, danger_level, cashed_in)
          = ($1, $2, $3, $4) WHERE id = $5"
    # prepare SQL statement
    db.prepare("update", sql)
    # define values to pass into statement
    values = [@name, @bounty, @danger_level, @cashed_in, @id]
    # execute statement with values
    db.exec_prepared("update", values)
    db.close()
  end

  def delete
    # define db and location
    db = PG.connect( {dbname: 'bounties', host: 'localhost'} )
    # define SQL command
    sql = "DELETE FROM bounty_list WHERE id = $1"
    db.prepare("delete", sql)
    values = [@id]
    db.exec_prepared("delete", values)
    db.close()
  end

  def Bounty.delete_all
    # define db and location
    db = PG.connect( {dbname: 'bounties', host: 'localhost'} )
    # define SQL command
    sql = "DELETE FROM bounty_list"
    db.exec(sql)
    db.close()
  end

  def Bounty.find(name)
    # define db and location
    db = PG.connect( {dbname: 'bounties', host: 'localhost'} )
    # define SQL command
    sql = "SELECT * FROM bounty_list WHERE name = $1"
    db.prepare("find", sql)
    value = [name]
    bounty_obj = db.exec_prepared("find", value)
    db.close
    return Bounty.new(bounty_obj[0])
  end

  # NOT WORKING
  def Bounty.find_by(field, data)
    # define db and location
    db = PG.connect( {dbname: 'bounties', host: 'localhost'} )
    # define SQL command
    sql = "SELECT * FROM bounty_list WHERE #{field}= $1"
    # binding.pry
    db.prepare("find_by", sql)
    values = [data]
    bounty_objs = db.exec_prepared("find_by", values)
    db.close
    # return bounty_obj
    return bounty_objs.map{|bounty| Bounty.new(bounty)}
  end

  # DELETE all Bounties that have been Cashed, i.e where cashed_in = t
  def Bounty.delete_cashed_bounties
    # define db and location
    db = PG.connect( {dbname: 'bounties', host: 'localhost'} )
    # define SQL command
    sql = "DELETE FROM bounty_list WHERE cashed_in = 't'"
    db.exec(sql)
    db.close
  end

end
