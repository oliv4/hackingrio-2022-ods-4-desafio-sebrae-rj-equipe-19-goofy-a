import { TypeOrmModule } from '@nestjs/typeorm';
import { Module } from '@nestjs/common';
import { BadgesRepository } from './badge.repository';
import { BadgesService } from './badge.service';

@Module({
  imports: [TypeOrmModule.forFeature([BadgesRepository])],
  providers: [BadgesService],
  exports: [BadgesService],
})
export class BadgesModule {}
