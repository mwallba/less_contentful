import { Application } from 'stimulus'
import { definitionsFromContext } from 'stimulus/webpack-helpers'

const application = Application.start()
const context = require.context('./controllers', true, /\.js$/)
console.log("controller definitions:", definitionsFromContext(context))
application.load(definitionsFromContext(context))
