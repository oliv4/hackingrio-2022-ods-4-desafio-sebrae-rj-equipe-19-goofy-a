import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { INestApplication } from '@nestjs/common';

export default class SwaggerConfig {
  static init(app: INestApplication): void {
    const options = new DocumentBuilder()
      .setTitle('HackingRio equipe 19 - API')
      .setDescription('HackingRio equipe 19 - API')
      .setVersion('1.0')
      .addBearerAuth()
      .build();

    const document = SwaggerModule.createDocument(app, options);
    SwaggerModule.setup('docs', app, document, {
      explorer: false,
    });
  }
}
