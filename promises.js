const request = require('request-promise-native');

// fs.readFileAsync('./app.j.s').then( data => {
//   res.render('index' data)

// }).catch(err => {
//   logger.error(err)
// })

request('https://swapi.co/api/people/1').then( (res) => {
  console.log('res', res)
  console.log('res.body', res.body)
  const data = JSON.parse(res)
  console.log('data',data)
  const{ homeworld } = data
  console.log('homeworld', homeworld)
  return request(homeworld)
  const data = JSON.parse(res)
  console.log('second then block data', data)
  const { films } = data
  const promiseList = films.map ( filmUrl => {
    return request(filmUrl)
  })
  return Promise.all(promiseList)
})
.then( filmList => {
  console.log('filmList', filmList)
})
.catch( (err) => {
  console.log('ERROR', err)
})

Knex.raw('SELECT * FROM users')
.then( users => {
  res.render('usertemplate', users)
})

