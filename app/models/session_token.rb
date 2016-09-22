class SessionToken
  TTL = 1.minutes
  
  def self.store
    @store ||= Hash.new
  end

  def initialize(existing_token=nil)
    @token = existing_token
    self.last_seen = Time.zone.now unless expired?
  end

  def token
    @token ||= MicroToken.generate 128
  end

  def ttl
    return TTL unless last_seen
    elapsed = Time.zone.now - last_seen
    remaining = (TTL - elapsed).floor
    remaining > 0 ? remaining : 0
  end

  def last_seen
    store[:last_seen_at]
  end

  def last_seen=(as_at)
    store[:last_seen_at] = as_at
    # $redis.set(token, store.to_json)
  end

  def user
    return if expired?
    store[:user]
  end

  def user=(user)
    store[:user] = user
    # $redis.set(token, store.to_json)
  end

  def expired?
    ttl < 1
  end

  def valid?
    !expired?
  end

  private
  def store
    # JSON.parse($redis.get(token)) ||= {}
    self.class.store[token] ||= {}
  end
end