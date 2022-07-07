require("./styles/index.css")

function memoize(method) {
  const cache = {}
  return async () => {
    const args = JSON.stringify(arguments)
    cache[args] = cache[args] || method.apply(this, arguments)
    return cache[args]
  }
}

const getConfig = memoize(async () => {
  const c = await import(/* webpackIgnore: true */ './env.js')
  return c.default
})

const info = {
  name          : INFO_NAME,
  title         : INFO_TITLE,
  description   : INFO_DESCRIPTION,
  contact       : INFO_CONTACT,
  documentation : INFO_DOCUMENTATION,
}

const version = {
  commit        : VERSION_COMMIT,
  tag           : VERSION_TAG,
  date          : VERSION_DATE,
}

getConfig().then(env => {
  require("./output/Main").main({
    "info": info,
    "version": version,
    "env": env,
  })()
})
