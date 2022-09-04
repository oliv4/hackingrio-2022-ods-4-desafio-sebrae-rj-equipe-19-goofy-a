import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { EventChallengesEntity } from './event-challenges.entity';
import { EventChallengesRepository } from './event-challenges.repository';
import { EventsEntity } from './events.entity';
import { EventsRepository } from './events.repository';

@Injectable()
export class EventsService {
  constructor(
    @InjectRepository(EventsRepository)
    private readonly eventsRepository: EventsRepository,
    @InjectRepository(EventChallengesRepository)
    private readonly eventChallengesRepository: EventChallengesRepository,
  ) {}

  public async getAllActiveEvents(): Promise<EventsEntity[]> {
    const events = await this.eventsRepository.findAllActiveEvents();
    if (!events) throw new NotFoundException('There is not active events');
    return events;
  }

  public async getEventChallengesByEventId(
    id: string,
  ): Promise<EventChallengesEntity[]> {
    const challenges =
      await this.eventChallengesRepository.getEventChallengesByEventId(id);
    if (!challenges)
      throw new NotFoundException(
        'There is not active challenges for this event',
      );
    return challenges;
  }

  public async getEventByQuizId(id: string): Promise<EventsEntity> {
    return this.eventsRepository.getEventByQuizId(id);
  }
}
